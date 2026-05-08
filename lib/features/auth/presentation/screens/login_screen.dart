import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/auth_controller.dart';
import '../widgets/auth_message.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_validators.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;

  final success =
      await ref.read(authControllerProvider.notifier).signIn(
            email: _emailController.text,
            password: _passwordController.text,
          );

  if (success && mounted) {
    context.go('/home');
  }
}

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    return AuthScaffold(
      title: 'Sign in',
      subtitle: 'Manage meals, expenses, and communication in one place.',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AuthMessage(message: authState.errorMessage),
            if (authState.errorMessage != null) const SizedBox(height: 12),
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
              prefixIcon: Icons.lock_outline_rounded,
              obscureText: true,
              validator: AuthValidators.password,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.go('/auth/forgot'),
                child: const Text('Forgot password?'),
              ),
            ),
            const SizedBox(height: 8),
            AuthPrimaryButton(
              text: 'Sign in',
              isLoading: authState.isLoading,
              onPressed: _submit,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go('/auth/signup'),
              child: const Text('Create account'),
            ),
          ],
        ),
      ),
    );
  }
}
