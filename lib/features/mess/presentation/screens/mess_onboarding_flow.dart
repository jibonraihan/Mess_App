import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_app/features/mess/presentation/screens/create_mess_screen.dart';
import 'package:mess_app/features/mess/presentation/screens/join_mess_screen.dart';
import 'package:mess_app/features/mess/application/mess_controller.dart';
import 'package:mess_app/features/mess/application/mess_state.dart';

class MessOnboardingFlow extends ConsumerWidget {
  const MessOnboardingFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the state to determine which screen to show
    final messState = ref.watch(messControllerProvider);

    return Scaffold(
      body: Center(
        child: messState.when(
          loading: () => const CircularProgressIndicator(),
          notInMess: () => _buildInitialState(context, ref),
          loaded: (mess) => _buildMessLoaded(context, mess), // This screen is for onboarding, so if loaded, we might navigate away
          error: (message) => Text('Error: $message'),
        ),
      ),
    );
  }

  Widget _buildInitialState(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.food_bank_outlined, size: 100, color: Colors.teal),
          const SizedBox(height: 24),
          Text(
            'Welcome to MessConnect!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Manage your mess expenses, chats, and meals seamlessly.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Create a New Mess'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateMessScreen()));
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            icon: const Icon(Icons.login),
            label: const Text('Join an Existing Mess'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const JoinMessScreen()));
            },
            style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
          ),
        ],
      ),
    );
  }

  // If the user is already loaded into a mess during onboarding, navigate them to the main app
  Widget _buildMessLoaded(BuildContext context, Mess mess) {
    // In a real app, you would likely navigate to the main app screen here
    // For now, we can just show a message or a button to proceed
    // This part assumes onboarding might be skipped if user already has a mess
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
          const SizedBox(height: 24),
          Text(
            'You are already part of a mess!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Mess: ${mess.name}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to the main app screen (e.g., HomeScreen)
              print('Navigate to main app screen');
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
            child: const Text('Go to App'),
          ),
        ],
      ),
    );
  }
}
