import 'package:flutter/material.dart';
import '../../../../core/widgets/feature_placeholder.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePlaceholder(
      title: 'Admin Roles',
      description:
          'Prepared for role-based access control, member approvals, and permission audits.',
      icon: Icons.admin_panel_settings_rounded,
    );
  }
}
