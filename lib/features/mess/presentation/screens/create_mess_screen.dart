import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mess_app/features/mess/application/mess_controller.dart';
import 'package:mess_app/features/mess/application/mess_state.dart';
import 'package:go_router/go_router.dart';

class CreateMessScreen extends ConsumerStatefulWidget {
  const CreateMessScreen({super.key});

  @override
  ConsumerState<CreateMessScreen> createState() => _CreateMessScreenState();
}

class _CreateMessScreenState extends ConsumerState<CreateMessScreen> {
  final _messNameController = TextEditingController();
  String? _errorMessage;
  String? _generatedCode;
  final bool _isSuccess = false;

  @override
  void dispose() {
    _messNameController.dispose();
    super.dispose();
  }

  Future<void> _createMess() async {
    final messName = _messNameController.text.trim();
    if (messName.isEmpty) {
      setState(() {
        _errorMessage = 'Mess name cannot be empty.';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    try {
      await ref.read(messControllerProvider.notifier).createMess(messName);
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to create mess. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Listen to the state to handle success and error
    ref.listen<MessState>(
      messControllerProvider,
      (previous, next) {
        next.whenOrNull(
          loaded: (mess) {
            context.go('/home');
            },
          error: (message) {
            setState(() {
              _errorMessage = message;
            });
          },
        );
      },
    );

    final isLoading = ref.watch(messControllerProvider).maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Mess'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 0.1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: _isSuccess
                ? _buildSuccessLayout(context, _generatedCode!)
                : _buildInputLayout(context, isLoading, textTheme, colorScheme),
          ),
        ),
      ),
    );
  }

  Widget _buildInputLayout(BuildContext context, bool isLoading,
      TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      key: const ValueKey('input_layout'),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Icons.group_add_rounded, size: 80, color: colorScheme.primary),
        const Gap(24),
        Text(
          'Start a new community',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Gap(8),
        Text(
          'Create a name for your mess to get started.',
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
        const Gap(32),
        TextField(
          controller: _messNameController,
          decoration: InputDecoration(
            labelText: 'Mess Name',
            hintText: 'e.g., The Hungry Coders',
            errorText: _errorMessage,
            prefixIcon: const Icon(Icons.group_work_outlined),
          ),
          autofocus: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _createMess(),
        ),
        const Gap(24),
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else
          ElevatedButton(
            onPressed: _createMess,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Create Mess', style: TextStyle(fontSize: 16)),
          ),
      ],
    );
  }

  Widget _buildSuccessLayout(BuildContext context, String code) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      key: const ValueKey('success_layout'),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Icons.check_circle_rounded, size: 80, color: colorScheme.primary),
        const Gap(24),
        Text(
          'Mess created successfully!',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Gap(32),
        Text(
          'Share this invite code with your friends:',
          style: textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const Gap(16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.primary.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Text(
                code,
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const Gap(16),
              OutlinedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invite code copied to clipboard!')),
                  );
                },
                icon: const Icon(Icons.copy_rounded),
                label: const Text('Copy Code'),
              ),
            ],
          ),
        ),
        const Gap(48),
        FilledButton(
          onPressed: () {
              context.go('/home');
               },
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Go to Mess', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
