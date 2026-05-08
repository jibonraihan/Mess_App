import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/responsive/responsive_breakpoints.dart';
import '../../../../core/widgets/avatar_image.dart';
import '../../../../core/widgets/section_card.dart';
import '../../domain/chat_domain.dart';

class ChatHeaderCard extends ConsumerWidget {
  const ChatHeaderCard({
    required this.onlineCount,
    required this.unreadCount,
    required this.pinnedMessages,
    required this.announcements,
    super.key,
  });

  final int onlineCount;
  final int unreadCount;
  final List<PinnedMessage> pinnedMessages;
  final List<AdminAnnouncement> announcements;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final showTopSection = 
        pinnedMessages.isNotEmpty || announcements.isNotEmpty || unreadCount > 0;

    if (!showTopSection) {
      return const SizedBox.shrink();
    }

    return SectionCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          if (unreadCount > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: colorScheme.tertiaryContainer.withOpacity(0.4),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
              ),
              child: Text(
                '$unreadCount unread messages',
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onTertiaryContainer,
                ),
              ),
            ),
          if (pinnedMessages.isNotEmpty)
            _PinnedMessagesSection(pinnedMessages: pinnedMessages),
          if (announcements.isNotEmpty)
            _AdminAnnouncementsSection(announcements: announcements),
        ],
      ),
    );
  }
}

class _PinnedMessagesSection extends StatelessWidget {
  const _PinnedMessagesSection({
    required this.pinnedMessages,
  });

  final List<PinnedMessage> pinnedMessages;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Text(
            'Pinned Messages',
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pinnedMessages.length,
          itemBuilder: (context, index) {
            final message = pinnedMessages[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  Text(
                    'Pinned by ${message.pinnedBy}',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const Gap(8),
      ],
    );
  }
}

class _AdminAnnouncementsSection extends StatelessWidget {
  const _AdminAnnouncementsSection({
    required this.announcements,
  });

  final List<AdminAnnouncement> announcements;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Text(
            'Admin Announcements',
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            final announcement = announcements[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.tertiaryContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.tertiary.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement.title,
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onTertiaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    announcement.message,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onTertiaryContainer,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const Gap(8),
      ],
    );
  }
}
