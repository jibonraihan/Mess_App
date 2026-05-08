enum UserRole { admin, member }

class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    required this.displayName,
    this.role,
    this.onboardingCompleted = false,
  });

  final String id;
  final String email;
  final String displayName;
  final UserRole? role;
  final bool onboardingCompleted;

  AuthUser copyWith({
    String? id,
    String? email,
    String? displayName,
    UserRole? role,
    bool? onboardingCompleted,
  }) {
    return AuthUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    );
  }
}
