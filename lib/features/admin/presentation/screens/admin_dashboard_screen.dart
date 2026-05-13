import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../mess/application/mess_controller.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messState = ref.watch(messControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B16),

      appBar: AppBar(
        title: const Text('Admin'),

        backgroundColor: const Color(0xFF111120),
      ),

      body: messState.maybeWhen(
        loaded: (mess) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  'Mess Information',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: const Color(0xFF171727),

                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 56,

                        backgroundColor: const Color(0xFF5B55A3),

                        backgroundImage: mess.avatarBytes != null
                            ? MemoryImage(mess.avatarBytes!)
                            : null,

                        child: mess.avatarBytes == null
                            ? Text(
                                mess.name.substring(0, 1).toUpperCase(),

                                style: const TextStyle(
                                  color: Colors.white,

                                  fontSize: 40,

                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),

                      const SizedBox(height: 20),

                      Text(
                        mess.name,

                        style: const TextStyle(
                          color: Colors.white,

                          fontSize: 28,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        mess.description ?? 'No description yet',

                        textAlign: TextAlign.center,

                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),

                      const SizedBox(height: 32),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,

                                vertical: 18,
                              ),

                              decoration: BoxDecoration(
                                color: const Color(0xFF111120),

                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  const Text(
                                    'Invite Code',

                                    style: TextStyle(
                                      color: Colors.white54,

                                      fontSize: 14,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    mess.inviteCode,

                                    style: const TextStyle(
                                      color: Colors.white,

                                      fontSize: 26,

                                      fontWeight: FontWeight.bold,

                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          IconButton(
                            onPressed: () async {
                              await Clipboard.setData(
                                ClipboardData(text: mess.inviteCode),
                              );

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Invite code copied'),
                                  ),
                                );
                              }
                            },

                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xFF5B55A3),

                              padding: const EdgeInsets.all(18),
                            ),

                            icon: const Icon(
                              Icons.copy_rounded,

                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,

                        child: FilledButton.icon(
                          onPressed: () {},

                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF5B55A3),

                            padding: const EdgeInsets.symmetric(vertical: 18),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                          icon: const Icon(Icons.refresh),

                          label: const Text('Regenerate Invite Code'),
                        ),
                      ),
                      const SizedBox(height: 32),

                      const Text(
                        'Mess Members',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(24),

                        decoration: BoxDecoration(
                          color: const Color(0xFF171727),

                          borderRadius: BorderRadius.circular(28),
                        ),

                        child: Column(
                          children: [
                            _memberTile(
                              name: 'Raihan',
                              role: 'Admin',
                              color: const Color(0xFF5B55A3),
                            ),

                            const SizedBox(height: 16),

                            _memberTile(
                              name: 'Tanvir',
                              role: 'Member',
                              color: Colors.blue,
                            ),

                            const SizedBox(height: 16),

                            _memberTile(
                              name: 'Kanon',
                              role: 'Member',
                              color: Colors.green,
                            ),

                            const SizedBox(height: 16),

                            _memberTile(
                              name: 'Washim',
                              role: 'Moderator',
                              color: Colors.orange,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      const Text(
                        'Expense Overview',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      GridView.count(
                        shrinkWrap: true,

                        physics: const NeverScrollableScrollPhysics(),

                        crossAxisCount: 2,

                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,

                        childAspectRatio: 1.25,

                        children: [
                          _expenseCard(
                            title: 'Total Expense',
                            amount: '৳ 24,500',
                            icon: Icons.account_balance_wallet,
                            color: Colors.deepPurple,
                          ),

                          _expenseCard(
                            title: 'This Month',
                            amount: '৳ 8,200',
                            icon: Icons.calendar_month,
                            color: Colors.blue,
                          ),

                          _expenseCard(
                            title: 'Pending',
                            amount: '৳ 2,300',
                            icon: Icons.pending_actions,
                            color: Colors.orange,
                          ),

                          _expenseCard(
                            title: 'Meal Cost',
                            amount: '৳ 12,000',
                            icon: Icons.restaurant,
                            color: Colors.green,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(24),

                        decoration: BoxDecoration(
                          color: const Color(0xFF171727),

                          borderRadius: BorderRadius.circular(28),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Text(
                              'Recent Expense Categories',

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 22),

                            _expenseCategoryTile(
                              icon: Icons.restaurant,
                              title: 'Meal',
                              amount: '৳ 12,000',
                              color: Colors.green,
                            ),

                            const SizedBox(height: 16),

                            _expenseCategoryTile(
                              icon: Icons.lightbulb,
                              title: 'Electricity',
                              amount: '৳ 2,500',
                              color: Colors.orange,
                            ),

                            const SizedBox(height: 16),

                            _expenseCategoryTile(
                              icon: Icons.wifi,
                              title: 'Internet',
                              amount: '৳ 1,200',
                              color: Colors.blue,
                            ),

                            const SizedBox(height: 24),

                            SizedBox(
                              width: double.infinity,

                              child: FilledButton.icon(
                                onPressed: () {},

                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF5B55A3),

                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),

                                icon: const Icon(Icons.add),

                                label: const Text('Add Expense'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      const Text(
                        'Meal Management',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      GridView.count(
                        shrinkWrap: true,

                        physics: const NeverScrollableScrollPhysics(),

                        crossAxisCount: 2,

                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,

                        childAspectRatio: 1.25,

                        children: [
                          _mealStatCard(
                            title: 'Today Meals',
                            value: '28',
                            icon: Icons.restaurant,
                            color: Colors.green,
                          ),

                          _mealStatCard(
                            title: 'Meal Rate',
                            value: '৳ 78',
                            icon: Icons.attach_money,
                            color: Colors.orange,
                          ),

                          _mealStatCard(
                            title: 'Monthly Meals',
                            value: '842',
                            icon: Icons.calendar_month,
                            color: Colors.blue,
                          ),

                          _mealStatCard(
                            title: 'Pending Entries',
                            value: '6',
                            icon: Icons.pending_actions,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(24),

                        decoration: BoxDecoration(
                          color: const Color(0xFF171727),

                          borderRadius: BorderRadius.circular(28),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Text(
                              'Meal Breakdown',

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 22),

                            _mealBreakdownTile(
                              title: 'Breakfast',
                              meals: '252 meals',
                              color: Colors.orange,
                              icon: Icons.free_breakfast,
                            ),

                            const SizedBox(height: 16),

                            _mealBreakdownTile(
                              title: 'Lunch',
                              meals: '318 meals',
                              color: Colors.green,
                              icon: Icons.lunch_dining,
                            ),

                            const SizedBox(height: 16),

                            _mealBreakdownTile(
                              title: 'Dinner',
                              meals: '272 meals',
                              color: Colors.deepPurple,
                              icon: Icons.dinner_dining,
                            ),

                            const SizedBox(height: 24),

                            SizedBox(
                              width: double.infinity,

                              child: FilledButton.icon(
                                onPressed: () {},

                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF5B55A3),

                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),

                                icon: const Icon(Icons.add),

                                label: const Text('Add Meal Entry'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      const Text(
                        'Settings & Control',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(24),

                        decoration: BoxDecoration(
                          color: const Color(0xFF171727),

                          borderRadius: BorderRadius.circular(28),
                        ),

                        child: Column(
                          children: [
                            _settingsTile(
                              icon: Icons.notifications_active,
                              title: 'Notifications',
                              subtitle: 'Manage mess alerts & updates',
                              color: Colors.orange,
                              trailing: Switch(value: true, onChanged: (_) {}),
                            ),

                            const SizedBox(height: 18),

                            _settingsTile(
                              icon: Icons.download,
                              title: 'Export Backup',
                              subtitle: 'Download mess data backup',
                              color: Colors.blue,
                              trailing: FilledButton(
                                onPressed: () {},

                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF5B55A3),
                                ),

                                child: const Text('Export'),
                              ),
                            ),

                            const SizedBox(height: 18),

                            _settingsTile(
                              icon: Icons.logout,
                              title: 'Leave Mess',
                              subtitle: 'Exit from this mess community',
                              color: Colors.orangeAccent,
                              trailing: FilledButton(
                                onPressed: () {},

                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.orangeAccent,
                                ),

                                child: const Text('Leave'),
                              ),
                            ),

                            const SizedBox(height: 18),

                            _settingsTile(
                              icon: Icons.delete_forever,
                              title: 'Delete Mess',
                              subtitle: 'Permanent delete this mess',
                              color: Colors.redAccent,
                              trailing: FilledButton(
                                onPressed: () {},

                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),

                                child: const Text('Delete'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },

        orElse: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Widget _memberTile({
  required String name,
  required String role,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

    decoration: BoxDecoration(
      color: const Color(0xFF111120),

      borderRadius: BorderRadius.circular(22),
    ),

    child: Row(
      children: [
        CircleAvatar(
          radius: 28,

          backgroundColor: color,

          child: Text(
            name.substring(0, 1).toUpperCase(),

            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                name,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),

                decoration: BoxDecoration(
                  color: color.withOpacity(0.18),

                  borderRadius: BorderRadius.circular(30),
                ),

                child: Text(
                  role,

                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),

        PopupMenuButton<String>(
          color: const Color(0xFF171727),

          icon: const Icon(Icons.more_vert, color: Colors.white70),

          onSelected: (value) {},

          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'promote',

              child: Text('Promote to Admin'),
            ),

            const PopupMenuItem(value: 'remove', child: Text('Remove Member')),
          ],
        ),
      ],
    ),
  );
}

Widget _expenseCard({
  required String title,
  required String amount,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
      color: const Color(0xFF171727),
      borderRadius: BorderRadius.circular(24),

      border: Border.all(color: Colors.white10, width: 1.2),

      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.12),
          blurRadius: 20,
          spreadRadius: 1,
        ),
      ],
    ),

    child: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,

          child: Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: color.withOpacity(0.15),

              borderRadius: BorderRadius.circular(16),
            ),

            child: Icon(icon, color: color, size: 24),
          ),
        ),

        Expanded(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [
                    Colors.white.withOpacity(0.08),
                    Colors.white.withOpacity(0.03),
                  ],
                ),

                borderRadius: BorderRadius.circular(20),

                border: Border.all(color: Colors.white10, width: 1),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    amount,

                    style: const TextStyle(
                      color: Colors.white,

                      fontSize: 28,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    title,

                    textAlign: TextAlign.center,

                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _expenseCategoryTile({
  required IconData icon,
  required String title,
  required String amount,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),

    decoration: BoxDecoration(
      color: const Color(0xFF111120),

      borderRadius: BorderRadius.circular(20),
    ),

    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: color.withOpacity(0.18),

            borderRadius: BorderRadius.circular(16),
          ),

          child: Icon(icon, color: color),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Text(
            title,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        Text(
          amount,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _mealStatCard({
  required String title,
  required String value,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
      color: const Color(0xFF171727),
      borderRadius: BorderRadius.circular(24),

      border: Border.all(color: Colors.white10, width: 1.2),

      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.12),
          blurRadius: 20,
          spreadRadius: 1,
        ),
      ],
    ),

    child: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,

          child: Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: color.withOpacity(0.15),

              borderRadius: BorderRadius.circular(16),
            ),

            child: Icon(icon, color: color, size: 24),
          ),
        ),

        Expanded(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [
                    Colors.white.withOpacity(0.08),
                    Colors.white.withOpacity(0.03),
                  ],
                ),

                borderRadius: BorderRadius.circular(20),

                border: Border.all(color: Colors.white10, width: 1),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    value,

                    style: const TextStyle(
                      color: Colors.white,

                      fontSize: 28,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    title,

                    textAlign: TextAlign.center,

                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _mealBreakdownTile({
  required String title,
  required String meals,
  required Color color,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),

    decoration: BoxDecoration(
      color: const Color(0xFF111120),

      borderRadius: BorderRadius.circular(20),
    ),

    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: color.withOpacity(0.18),

            borderRadius: BorderRadius.circular(16),
          ),

          child: Icon(icon, color: color),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Text(
            title,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        Text(
          meals,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _settingsTile({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color color,
  required Widget trailing,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

    decoration: BoxDecoration(
      color: const Color(0xFF111120),

      borderRadius: BorderRadius.circular(22),

      border: Border.all(color: Colors.white10),
    ),

    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: color.withOpacity(0.15),

            borderRadius: BorderRadius.circular(16),
          ),

          child: Icon(icon, color: color),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                title,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                subtitle,

                style: const TextStyle(color: Colors.white60, fontSize: 14),
              ),
            ],
          ),
        ),

        trailing,
      ],
    ),
  );
}
