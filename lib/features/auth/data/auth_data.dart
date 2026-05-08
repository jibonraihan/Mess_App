import 'dart:async';
import '../domain/auth_domain.dart';
import '../domain/auth_user.dart';

class AuthRepositoryImpl implements AuthRepository {
  // In future Supabase integration, replace this in-memory flow with a
  // SupabaseAuthDataSource and map Supabase user/session payloads here.
  AuthRepositoryImpl() {
    _controller = StreamController<AuthUser?>.broadcast(
      onListen: () => _controller.add(_currentUser),
    );
  }

  AuthUser? _currentUser;
  late final StreamController<AuthUser?> _controller;

  @override
  Stream<AuthUser?> authStateChanges() => _controller.stream;

  @override
Future<AuthUser> signIn({
  required String email,
  required String password,
}) async {
  await Future<void>.delayed(const Duration(milliseconds: 700));

  _currentUser = AuthUser(
    id: 'user-1',
    email: email.trim(),
    displayName: 'Mess User',
    onboardingCompleted: true,
    role: UserRole.member,
  );

  _controller.add(_currentUser);

  return _currentUser!;
}

  @override
Future<AuthUser> signUp({
  required String name,
  required String email,
  required String password,
}) async {
  await Future<void>.delayed(const Duration(milliseconds: 900));

  _currentUser = AuthUser(
    id: 'user-${DateTime.now().millisecondsSinceEpoch}',
    email: email.trim(),
    displayName: name.trim(),
    onboardingCompleted: true,
    role: UserRole.member,
  );

  _controller.add(_currentUser);

  return _currentUser!;
}

  @override
  Future<void> sendPasswordReset(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
  }

  @override
  Future<AuthUser> selectRole(UserRole role) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final current = _currentUser;
    if (current == null) {
      throw StateError('Cannot select role without authenticated user.');
    }
    _currentUser = current.copyWith(role: role, onboardingCompleted: true);
    _controller.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
    _controller.add(null);
  }
}
