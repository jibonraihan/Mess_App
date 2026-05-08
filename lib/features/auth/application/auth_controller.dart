import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_data.dart';
import '../domain/auth_domain.dart';
import '../domain/auth_user.dart';
import 'auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthController(repository);
});

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._repository) : super(const AuthState()) {
    _subscription = _repository.authStateChanges().listen(
          (user) => state = state.copyWith(
            user: user,
            isInitializing: false,
            clearError: true,
          ),
        );
  }

  final AuthRepository _repository;
  late final StreamSubscription<AuthUser?> _subscription;

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _repository.signIn(
        email: email,
        password: password,
      );

      state = state.copyWith(isLoading: false);

      return true;
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unable to sign in right now.',
      );

      return false;
    }
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _repository.signUp(
        name: name,
        email: email,
        password: password,
      );

      state = state.copyWith(isLoading: false);

      return true;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Unable to create your account.',
      );

      return false;
    }
  }

  Future<bool> sendPasswordReset(String email) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _repository.sendPasswordReset(email);

      state = state.copyWith(isLoading: false);

      return true;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Password reset request failed.',
      );

      return false;
    }
  }

  Future<bool> selectRole(UserRole role) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _repository.selectRole(role);

      state = state.copyWith(isLoading: false);

      return true;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Could not save selected role.',
      );

      return false;
    }
  }

  // COMPLETE ONBOARDING
  void completeOnboarding() {
  final currentUser = state.user;

  if (currentUser == null) return;

  final updatedUser = currentUser.copyWith(
    onboardingCompleted: true,
  );

  state = state.copyWith(
    user: updatedUser,
  );
}

  Future<void> signOut() async {
    await _repository.signOut();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}