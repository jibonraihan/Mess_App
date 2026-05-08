import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_app/features/mess/application/mess_controller.dart';
import 'package:mess_app/features/mess/application/mess_state.dart';

class MessScreen extends ConsumerWidget {
  const MessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messState = ref.watch(messControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Mess'),
        actions: [
          // Settings or leave mess option
          if (messState is _Loaded) ...[
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                // TODO: Navigate to Mess Settings
              },
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app_rounded, color: Colors.red),
              onPressed: () async {
                // Show confirmation dialog before leaving
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Leave Mess'),
                      content: const Text(
                          'Are you sure you want to leave this mess? This action cannot be undone.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false), // Cancel
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true), // Confirm
                          child: const Text('Leave'),
                        ),
                      ],
                    );
                  },
                );
                if (confirm == true) {
                  ref.read(messControllerProvider.notifier).leaveMess();
                }
              },
            ),
          ]
        ],
      ),
      body: Center(
        child: messState.when(
          loading: () => const CircularProgressIndicator(),
          notInMess: () => _buildNotInMessLayout(context, ref),
          loaded: (mess) => _buildMessLoadedLayout(context, mess),
          error: (message) => Text('Error: $message'),
        ),
      ),
    );
  }

  Widget _buildNotInMessLayout(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.group_off_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'You are not currently in a mess.',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Create a new mess or join an existing one.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Create Mess'),
            onPressed: () {
              // TODO: Navigate to Create Mess Screen
              print('Navigate to Create Mess Screen');
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            icon: const Icon(Icons.login),
            label: const Text('Join Mess'),
            onPressed: () {
              // TODO: Navigate to Join Mess Screen
              print('Navigate to Join Mess Screen');
            },
            style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
          ),
        ],
      ),
    );
  }

  Widget _buildMessLoadedLayout(BuildContext context, Mess mess) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.group_rounded, size: 80, color: Colors.blueGrey), // Example icon
          const SizedBox(height: 16),
          Text(
            mess.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Invite Code: ${mess.inviteCode}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),
          // TODO: Add more mess details or actions here
          // e.g., list of members, quick actions for chat/expenses/meals
          Text('Welcome to ${mess.name}!', style: Theme.of(context).textTheme.bodyLarge), 
        ],
      ),
    );
  }
}
