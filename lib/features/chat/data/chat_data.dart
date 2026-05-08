import 'dart:async';
import '../domain/chat_domain.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Stream<ChatRoomSnapshot> watchRoom(String roomId) {
    // Replace this mock stream with Supabase Realtime channel stream later.
    final controller = StreamController<ChatRoomSnapshot>();
    final messages = <ChatMessage>[
      ChatMessage(
        id: 'm1',
        senderName: 'Admin',
        message: 'Please clear your monthly dues by Saturday.',
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
        isMine: false,
        type: ChatMessageType.announcement,
      ),
      ChatMessage(
        id: 'm2',
        senderName: 'Rahim',
        message: 'Anyone available for market duty tomorrow morning?',
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
        isMine: false,
        type: ChatMessageType.text,
        reactions: const [ChatReaction(emoji: '👍', count: 4)],
      ),
      ChatMessage(
        id: 'm3',
        senderName: 'You',
        message: 'I can do it after 9 AM.',
        createdAt: DateTime.now().subtract(const Duration(hours: 7, minutes: 50)),
        isMine: true,
        type: ChatMessageType.text,
      ),
      ChatMessage(
        id: 'm4',
        senderName: 'Karim',
        message: 'Here is the utility receipt for this month.',
        createdAt: DateTime.now().subtract(const Duration(hours: 2, minutes: 35)),
        isMine: false,
        type: ChatMessageType.file,
        fileName: 'utility_bill_may.pdf',
      ),
      ChatMessage(
        id: 'm5',
        senderName: 'Sakib',
        message: 'Voice note',
        createdAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
        isMine: false,
        type: ChatMessageType.voice,
        voiceDurationSec: 21,
      ),
      ChatMessage(
        id: 'm6',
        senderName: 'Jamal',
        message: 'Dinner menu looks great today.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 48)),
        isMine: false,
        type: ChatMessageType.text,
        replyToMessageId: 'm2',
        replyPreview: 'Anyone available for market duty tomorrow morning?',
        reactions: const [
          ChatReaction(emoji: '🔥', count: 2),
          ChatReaction(emoji: '😄', count: 1),
        ],
      ),
      ChatMessage(
        id: 'marker',
        senderName: '',
        message: '',
        createdAt: DateTime.now().subtract(const Duration(minutes: 40)),
        isMine: false,
        type: ChatMessageType.text,
        isUnreadMarker: true,
      ),
      ChatMessage(
        id: 'm7',
        senderName: 'Tanjim',
        message: 'Photo from today market run.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 35)),
        isMine: false,
        type: ChatMessageType.image,
      ),
    ];

    var tick = 0;
    Timer? timer;

    void emit({List<String> typingUsers = const []}) {
      controller.add(
        ChatRoomSnapshot(
          roomTitle: 'Mess Group Chat',
          onlineCount: 17,
          messages: List.unmodifiable(messages),
          pinnedMessages: const [
            PinnedMessage(
              text: 'Monthly meeting on Sunday 8:30 PM.',
              pinnedBy: 'Admin',
            ),
          ],
          announcements: const [
            AdminAnnouncement(
              title: 'Admin announcement',
              message: 'Friday lunch count closes at 10:30 AM.',
            ),
          ],
          typingUsers: typingUsers,
          unreadCount: 3,
        ),
      );
    }

    emit();

    timer = Timer.periodic(const Duration(seconds: 4), (_) {
      tick++;
      if (tick % 2 == 1) {
        emit(typingUsers: const ['Karim']);
        return;
      }
      messages.add(
        ChatMessage(
          id: 'live-$tick',
          senderName: 'Karim',
          message: 'Realtime mock update #$tick',
          createdAt: DateTime.now(),
          isMine: false,
          type: ChatMessageType.text,
        ),
      );
      emit();
    });

    controller.onCancel = () {
      timer?.cancel();
    };

    return controller.stream;
  }
}
