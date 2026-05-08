class AuthValidators {
  static String? requiredField(String? value, String label) {
    if (value == null || value.trim().isEmpty) return '$label is required';
    return null;
  }

  static String? email(String? value) {
    final required = requiredField(value, 'Email');
    if (required != null) return required;
    final email = value!.trim();
    final pattern = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!pattern.hasMatch(email)) return 'Enter a valid email';
    return null;
  }

  static String? password(String? value) {
    final required = requiredField(value, 'Password');
    if (required != null) return required;
    if (value!.trim().length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? name(String? value) {
    final required = requiredField(value, 'Name');
    if (required != null) return required;
    if (value!.trim().length < 2) return 'Name is too short';
    return null;
  }
}
