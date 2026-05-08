enum ChatMessageType { text, image, file, voice, announcement }

class ChatReaction {
  const ChatReaction({
    required this.emoji,
    required this.count,
  });

  final String emoji;
  final int count;
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.senderName,
    required this.message,
    required this.createdAt,
    required this.isMine,
    required this.type,
    this.replyToMessageId,
    this.replyPreview,
    this.fileName,
    this.voiceDurationSec,
    this.reactions = const [],
    this.isUnreadMarker = false,
  });

  final String id;
  final String senderName;
  final String message;
  final DateTime createdAt;
  final bool isMine;
  final ChatMessageType type;
  final String? replyToMessageId;
  final String? replyPreview;
  final String? fileName;
  final int? voiceDurationSec;
  final List<ChatReaction> reactions;
  final bool isUnreadMarker;
}

class PinnedMessage {
  const PinnedMessage({
    required this.text,
    required this.pinnedBy,
  });

  final String text;
  final String pinnedBy;
}

class AdminAnnouncement {
  const AdminAnnouncement({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;
}

class ChatRoomSnapshot {
  const ChatRoomSnapshot({
    required this.roomTitle,
    required this.onlineCount,
    required this.messages,
    required this.pinnedMessages,
    required this.announcements,
    required this.typingUsers,
    required this.unreadCount,
  });

  final String roomTitle;
  final int onlineCount;
  final List<ChatMessage> messages;
  final List<PinnedMessage> pinnedMessages;
  final List<AdminAnnouncement> announcements;
  final List<String> typingUsers;
  final int unreadCount;
}

abstract class ChatRepository {
  Stream<ChatRoomSnapshot> watchRoom(String roomId);
}
