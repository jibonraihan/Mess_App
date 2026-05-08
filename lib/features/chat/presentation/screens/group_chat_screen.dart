import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/responsive/responsive_breakpoints.dart';
import '../../application/chat_controller.dart';
import '../../domain/chat_domain.dart';
import '../widgets/chat_composer.dart';
//import '../widgets/chat_header_card.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/typing_indicator.dart';

class GroupChatScreen extends ConsumerStatefulWidget {
  const GroupChatScreen({super.key});

  @override
  ConsumerState<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends ConsumerState<GroupChatScreen> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();
  bool _showScrollToBottomButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final showButton = _scrollController.position.pixels <
          _scrollController.position.maxScrollExtent;
      if (showButton != _showScrollToBottomButton) {
        setState(() {
          _showScrollToBottomButton = showButton;
        });
      }
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatControllerProvider);
    final room = state.room;
    final isDesktop = ResponsiveBreakpoints.isDesktop(context);

    if (state.isLoading && room == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (room == null) {
      return const Center(child: Text('Chat unavailable'));
    }

    final messageItems = _buildMessageItems(room.messages);
    return Scaffold(
      appBar: AppBar(
        title: Text(room.roomTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () {
              // TODO: Navigate to ChatDetailsScreen
              print('Navigate to ChatDetailsScreen');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: const SizedBox.shrink(),
          ),
          Expanded(
            child: isDesktop
                ? Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: _MessagesThread(
                          items: messageItems,
                          scrollController: _scrollController,
                        ),
                      ),
                      Container(
                        width: 280,
                        margin: const EdgeInsets.only(right: 10, bottom: 8),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Room info',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                Text('Channel: ${room.roomTitle}'),
                                const SizedBox(height: 6),
                                Text('Style: mock realtime stream'),
                                const SizedBox(height: 8),
                                TypingIndicator(users: room.typingUsers),
                                const SizedBox(height: 16),
                                Text(
                                  'Members',
                                  style:
                                      Theme.of(context).textTheme.titleSmall,
                                ),
                                // TODO: Add a list of online members here
                                // For now, just a button to view all members
                                TextButton(
                                  onPressed: () {
                                    // TODO: Navigate to ChatMembersScreen
                                    print('Navigate to ChatMembersScreen');
                                  },
                                  child: const Text('View All Members'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : _MessagesThread(
                    items: messageItems,
                    scrollController: _scrollController,
                  ),
          ),
          if (!isDesktop)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TypingIndicator(users: room.typingUsers),
            ),
          ChatComposer(
            controller: _inputController,
            onSend: () {
              _inputController.clear();
            },
          ),
        ],
      ),
      floatingActionButton: _showScrollToBottomButton
          ? FloatingActionButton.small(
              onPressed: _scrollToBottom,
              child: const Icon(Icons.arrow_downward_rounded),
            )
          : null,
    );
  }

  List<_MessageListItem> _buildMessageItems(List<ChatMessage> messages) {
    final items = <_MessageListItem>[];
    DateTime? lastDate;
    for (final message in messages) {
      final d = DateTime(message.createdAt.year, message.createdAt.month, message.createdAt.day);
      if (lastDate == null || d != lastDate) {
        items.add(_MessageListItem.date(d));
        lastDate = d;
      }
      items.add(_MessageListItem.message(message));
    }
    return items;
  }
}

class _MessagesThread extends StatelessWidget {
  const _MessagesThread({required this.items, required this.scrollController});

  final List<_MessageListItem> items;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        if (item.date != null) {
          final date = item.date!;
          final label = '${date.day}/${date.month}/${date.year}';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Chip(
                label: Text(label),
              ),
            ),
          );
        }
        return ChatMessageBubble(message: item.message!);
      },
    );
  }
}

class _MessageListItem {
  const _MessageListItem._({this.message, this.date});

  factory _MessageListItem.message(ChatMessage message) {
    return _MessageListItem._(message: message);
  }

  factory _MessageListItem.date(DateTime date) {
    return _MessageListItem._(date: date);
  }

  final ChatMessage? message;
  final DateTime? date;
}

