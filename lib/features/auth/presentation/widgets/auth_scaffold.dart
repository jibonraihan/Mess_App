import 'package:flutter/material.dart';
import '../../../../app/theme/theme_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/responsive/responsive_breakpoints.dart';

class AuthScaffold extends ConsumerWidget {
  const AuthScaffold({
    required this.title,
    required this.subtitle,
    required this.child,
    super.key,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveBreakpoints.isDesktop(context);

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  padding: const EdgeInsets.all(36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.displaySmall),
                      const SizedBox(height: 12),
                      Text(subtitle, style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
            Expanded(
              flex: isDesktop ? 2 : 1,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isDesktop) ...[
                          Text(title, style: Theme.of(context).textTheme.headlineMedium),
                          const SizedBox(height: 8),
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 24),
                        ],
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: child,
                        ),
                        const SizedBox(height: 16),
                        IconButton.outlined(
                          tooltip: 'Toggle theme',
                          onPressed: () =>
                              ref.read(themeModeProvider.notifier).toggleTheme(),
                          icon: const Icon(Icons.dark_mode_rounded),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
