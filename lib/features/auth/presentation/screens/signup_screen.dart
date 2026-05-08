import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/auth_controller.dart';
import '../widgets/auth_message.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_validators.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;

  await ref.read(authControllerProvider.notifier).signUp(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

  if (!mounted) return;

  context.go('/auth/choose-mess');
}

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    return AuthScaffold(
      title: 'Create account',
      subtitle: 'Start with secure access and personalized role setup.',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AuthMessage(message: authState.errorMessage),
            if (authState.errorMessage != null) const SizedBox(height: 12),
            AuthTextField(
              controller: _nameController,
              label: 'Full name',
              prefixIcon: Icons.person_outline_rounded,
              validator: AuthValidators.name,
            ),
            const SizedBox(height: 12),
            AuthTextField(
              controller: _emailController,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              validator: AuthValidators.email,
            ),
            const SizedBox(height: 12),
            AuthTextField(
              controller: _passwordController,
              label: 'Password',
              obscureText: true,
              prefixIcon: Icons.lock_outline_rounded,
              validator: AuthValidators.password,
            ),
            const SizedBox(height: 18),
            AuthPrimaryButton(
              text: 'Create account',
              isLoading: authState.isLoading,
              onPressed: _submit,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go('/auth/login'),
              child: const Text('Already have an account? Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
