import 'package:mess_app/features/mess/data/mess_repository.dart';
import 'package:mess_app/features/mess/domain/mess.dart';
import 'package:mess_app/features/mess/application/mess_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../../auth/application/auth_controller.dart';

// Provider for the MessRepository
final messRepositoryProvider = Provider<MessRepository>((ref) {
  // In a real app, this would be a service that interacts with a database or API
  return InMemoryMessRepository();
});

// StateNotifierProvider for managing the current mess and user's mess data
final messControllerProvider =
    StateNotifierProvider<MessController, MessState>((ref) {
  final repository = InMemoryMessRepository();

  return MessController(ref, repository);
});

class MessController extends StateNotifier<MessState> {
  final Ref ref;
  MessController(this.ref, this._repository) : super(const MessState.loading()) {
    // Load the user's mess when the controller is initialized
    loadUserMess();
  }

  final MessRepository _repository;
  final String _userId = 'mock-user-id';

  // Fetch the mess the user belongs to
  Future<void> loadUserMess() async {
    try {
      final mess = _repository.getUserMess(_userId);
      if (mess != null) {
        state = MessState.loaded(mess: mess);
      } else {
        // If user is not in any mess, set state to notInMess
        state = const MessState.notInMess();
      }
    } catch (e) {
      state = MessState.error(message: 'Failed to load mess data: ${e.toString()}');
    }
  }

  // Create a new mess
Future<void> createMess(String messName) async {
  state = const MessState.loading();

  try {
    // Generate invite code
    final inviteCode = _generateInviteCode();

    final newMess = Mess(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: messName,
      createdAt: DateTime.now(),
      inviteCode: inviteCode,
      adminId: _userId,
      memberIds: [_userId],
    );

    await _repository.createMess(newMess);

    // COMPLETE ONBOARDING
    final authNotifier = ref.read(authControllerProvider.notifier);
    authNotifier.completeOnboarding();

    // UPDATE STATE
    state = MessState.loaded(mess: newMess);
  } catch (e) {
    state = MessState.error(
      message: 'Failed to create mess: ${e.toString()}',
    );
  }
}

  // Join a mess using an invite code
  Future<void> joinMess(String inviteCode) async {
    state = const MessState.loading();
    try {
      await _repository.joinMess(_userId, inviteCode);
      // Re-fetch the mess data to confirm join
      loadUserMess();
    } catch (e) {
      state = MessState.error(message: 'Failed to join mess: ${e.toString()}');
    }
  }

  // Leave the current mess
  Future<void> leaveMess() async {
    state = const MessState.loading();
    try {
      final currentState = state;
    } catch (e) {
      state = MessState.error(message: 'Failed to leave mess: ${e.toString()}');
    }
  }

  // Generate a unique invite code (simple mock implementation)
  String _generateInviteCode() {
    // In a real app, this would be more robust, ensuring uniqueness
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
  }
}
