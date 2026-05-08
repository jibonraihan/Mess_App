import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_app/features/mess/application/mess_controller.dart';
import 'package:mess_app/features/mess/application/mess_state.dart';
import 'package:mess_app/features/mess/domain/mess.dart';
import 'package:mess_app/features/mess/presentation/screens/mess_screen.dart';

// This widget will decide whether to show the onboarding flow or the main app
class MessWrapper extends ConsumerWidget {
  const MessWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the mess controller state
    final messState = ref.watch(messControllerProvider);

    return messState.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      notInMess: () => const MessOnboardingFlow(), // Show onboarding if not in a mess
      loaded: (mess) => _buildAppStructure(context, mess), // Show main app if loaded into a mess
      error: (message) => Scaffold(body: Center(child: Text('Error: $message'))), // Show error message
    );
  }

  // Build the main app structure once a mess is loaded
  Widget _buildAppStructure(BuildContext context, Mess mess) {
    // This is where you would typically return your main MaterialApp or Scaffold
    // For now, let's just show the MessScreen as a placeholder for the main app content
    return MessScreen(); // Replace with your actual main app layout
  }
}
