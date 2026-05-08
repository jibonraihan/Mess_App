import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/theme_controller.dart';
import '../../features/auth/application/auth_controller.dart';

class AppShell extends ConsumerWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  static const _tabs = [
    ('/home', 'Home', Icons.dashboard_rounded),
    ('/chat', 'Chat', Icons.forum_rounded),
    ('/expenses', 'Expenses', Icons.account_balance_wallet_rounded),
    ('/meals', 'Meals', Icons.restaurant_menu_rounded),
    ('/admin', 'Admin', Icons.admin_panel_settings_rounded),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = _tabs.indexWhere((tab) => location.startsWith(tab.$1));
    final safeIndex = selectedIndex < 0 ? 0 : selectedIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[safeIndex].$2),
        actions: [
          IconButton(
            tooltip: 'Toggle dark mode',
            onPressed: () => ref.read(themeModeProvider.notifier).toggleTheme(),
            icon: const Icon(Icons.dark_mode_rounded),
          ),
          IconButton(
            tooltip: 'Sign out',
            onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: safeIndex,
        onDestinationSelected: (index) {
          if (index >= 0 && index < _tabs.length) {
            context.go(_tabs[index].$1);
          }
        },
        destinations: _tabs
            .map(
              (tab) => NavigationDestination(
                icon: Icon(tab.$3),
                label: tab.$2,
              ),
            )
            .toList(),
      ),
    );
  }
}
