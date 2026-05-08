import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mess_app/features/mess/application/mess_controller.dart';
import 'package:mess_app/features/mess/application/mess_state.dart';
import 'package:go_router/go_router.dart';

class JoinMessScreen extends ConsumerStatefulWidget {
  const JoinMessScreen({super.key});

  @override
  ConsumerState<JoinMessScreen> createState() => _JoinMessScreenState();
}

class _JoinMessScreenState extends ConsumerState<JoinMessScreen> {
  final _inviteCodeController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _inviteCodeController.dispose();
    super.dispose();
  }

  Future<void> _joinMess() async {
    final inviteCode = _inviteCodeController.text.trim();
    if (inviteCode.isEmpty) {
      setState(() {
        _errorMessage = 'Invite code cannot be empty.';
      });
      return;
    }

    if (inviteCode.length < 4) {
      setState(() {
        _errorMessage = 'Invite code must be at least 4 characters.';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    try {
      await ref.read(messControllerProvider.notifier).joinMess(inviteCode);
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to join mess. Please check the code.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Listen to the state for success or error
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
        title: const Text('Join Mess'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.handshake_rounded, size: 80, color: colorScheme.primary),
                const Gap(24),
                Text(
                  'Join your community',
                  style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Gap(8),
                Text(
                  'Enter the invite code provided by your mess admin to join.',
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const Gap(40),
                TextField(
                  controller: _inviteCodeController,
                  decoration: InputDecoration(
                    labelText: 'Invite Code',
                    hintText: 'e.g., FOOD123',
                    errorText: _errorMessage,
                    prefixIcon: const Icon(Icons.vpn_key_rounded),
                    helperText: 'Invite codes are case-sensitive.',
                  ),
                  textCapitalization: TextCapitalization.characters,
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _joinMess(),
                ),
                const Gap(32),
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  FilledButton(
                    onPressed: _joinMess,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Join Mess', style: TextStyle(fontSize: 16)),
                  ),
                const Gap(24),
                TextButton(
                  onPressed: () => context.go('/auth/choose-mess'),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
