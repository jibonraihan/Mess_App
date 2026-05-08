import 'package:flutter/material.dart';
import '../../domain/chat_domain.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    required this.message,
    this.onTapReply,
    super.key,
  });

  final ChatMessage message;
  final VoidCallback? onTapReply;

  @override
  Widget build(BuildContext context) {
    if (message.isUnreadMarker) {
      return _UnreadDivider();
    }

    final isMine = message.isMine;
    final bubbleColor = isMine
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.surfaceContainerHighest;
    final align = isMine ? Alignment.centerRight : Alignment.centerLeft;

    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: isMine ? const Radius.circular(16) : const Radius.circular(4),
      bottomRight: isMine ? const Radius.circular(4) : const Radius.circular(16),
    );

    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 360),
              decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isMine)
              Text(
                message.senderName,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
              ),
            ),
            if (message.type == ChatMessageType.announcement)
              _AdminAnnouncement(message: message),
            if (message.replyPreview != null) ...[
              if (!isMine) const SizedBox(height: 6),
              GestureDetector(
                onTap: onTapReply,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context)
                        .colorScheme
                        .surface
                        .withOpacity(0.8),
            ),
                  child: Text(
                    message.replyPreview!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
      ),
                ),
              ),
            ],
            if (message.type != ChatMessageType.announcement) ...[
              if (!isMine || message.replyPreview != null)
                const SizedBox(height: 6),
              _buildMessageByType(context),
            ],
            const SizedBox(height: 6),
            Text(
              '${message.createdAt.hour.toString().padLeft(2, '0')}:${message.createdAt.minute.toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            if (message.reactions.isNotEmpty) ...[
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                children: message.reactions
                    .map(
                      (item) => Chip(
                        label: Text(
                          '${item.emoji} ${item.count}',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMessageByType(BuildContext context) {
    switch (message.type) {
      case ChatMessageType.text:
        return Text(
          message.message,
          style: Theme.of(context).textTheme.bodyMedium,
        );
      case ChatMessageType.image:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: const Icon(Icons.image_rounded, size: 44),
            ),
            if (message.message.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                message.message,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        );
      case ChatMessageType.file:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.attach_file_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                message.fileName ?? 'attachment',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
        );
      case ChatMessageType.voice:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.play_circle_fill_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            const SizedBox(width: 8),
            Container(
              width: 120,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color:
                    Theme.of(context).colorScheme.primary.withOpacity(0.35),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${message.voiceDurationSec ?? 0}s',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      case ChatMessageType.announcement:
        return const SizedBox.shrink(); // Handled separately
}
  }
}

class _AdminAnnouncement extends StatelessWidget {
  const _AdminAnnouncement({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admin Announcement',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            message.message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
          ),
        ],
      ),
    );
  }
}

class _UnreadDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: Theme.of(context).colorScheme.tertiaryContainer,
            ),
            child: Text(
              'Unread messages',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

