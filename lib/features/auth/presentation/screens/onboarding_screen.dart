import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/auth_scaffold.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Mess Manager',
      subtitle: 'Modern platform for meals, expenses, chat, and admin control.',
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Column(
              children: const [
                Icon(Icons.groups_rounded, size: 64),
                SizedBox(height: 8),
                Text(
                  'Track meals, split expenses, and stay connected with your mess members.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => context.go('/auth/signup'),
              child: const Text('Get started'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => context.go('/auth/login'),
              child: const Text('I already have an account'),
            ),
          ),
        ],
      ),
    );
  }
}
