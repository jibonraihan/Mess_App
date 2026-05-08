import '../domain/chat_domain.dart';

class ChatState {
  const ChatState({
    this.room,
    this.isLoading = true,
    this.errorMessage,
  });

  final ChatRoomSnapshot? room;
  final bool isLoading;
  final String? errorMessage;

  ChatState copyWith({
    ChatRoomSnapshot? room,
    bool clearRoom = false,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ChatState(
      room: clearRoom ? null : (room ?? this.room),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
