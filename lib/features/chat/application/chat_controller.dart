import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/chat_data.dart';
import '../domain/chat_domain.dart';
import 'chat_state.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl();
});

final chatControllerProvider =
    StateNotifierProvider<ChatController, ChatState>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  final controller = ChatController(repo);
  controller.start('mess-main-room');
  return controller;
});

class ChatController extends StateNotifier<ChatState> {
  ChatController(this._repository) : super(const ChatState());

  final ChatRepository _repository;
  StreamSubscription<ChatRoomSnapshot>? _subscription;

  void start(String roomId) {
    _subscription?.cancel();
    state = state.copyWith(isLoading: true, clearError: true);
    _subscription = _repository.watchRoom(roomId).listen(
          (room) {
            state = state.copyWith(
              room: room,
              isLoading: false,
              clearError: true,
            );
          },
          onError: (_) {
            state = state.copyWith(
              isLoading: false,
              errorMessage: 'Unable to connect to chat stream.',
            );
          },
        );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
