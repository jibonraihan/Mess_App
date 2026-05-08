import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/auth_controller.dart';
import '../../domain/auth_user.dart';
import '../widgets/auth_scaffold.dart';

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    return AuthScaffold(
      title: 'Select role',
      subtitle: 'Set your app role to personalize access and dashboard modules.',
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        opacity: authState.isLoading ? 0.7 : 1,
        child: Column(
          children: [
            _RoleCard(
              icon: Icons.admin_panel_settings_rounded,
              title: 'Admin',
              subtitle: 'Manage members, permissions, and operational settings.',
              onTap: authState.isLoading
                  ? null
                  : () => ref
                      .read(authControllerProvider.notifier)
                      .selectRole(UserRole.admin),
            ),
            const SizedBox(height: 12),
            _RoleCard(
              icon: Icons.person_rounded,
              title: 'Member',
              subtitle: 'Daily usage for meals, chat, and expense tracking.',
              onTap: authState.isLoading
                  ? null
                  : () => ref
                      .read(authControllerProvider.notifier)
                      .selectRole(UserRole.member),
            ),
            const SizedBox(height: 18),
            if (authState.isLoading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(radius: 22, child: Icon(icon)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(subtitle),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
