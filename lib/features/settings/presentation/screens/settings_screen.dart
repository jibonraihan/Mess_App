import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0B0B16),

      body: Center(
        child: Text(
          'Settings',

          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
