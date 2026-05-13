import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../mess/application/mess_controller.dart';

class MessMember {
  final String name;
  final String phone;
  final String role;
  final Color color;

  const MessMember({
    required this.name,
    required this.phone,
    required this.role,
    required this.color,
  });
}

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  final ScrollController _memberScrollController = ScrollController();
  final List<MessMember> members = [
    const MessMember(
      name: 'Raihan',
      phone: '01843118076',
      role: 'Admin',
      color: Color(0xFF5B55A3),
    ),

    const MessMember(
      name: 'Tanvir',
      phone: '01512345678',
      role: 'Member',
      color: Colors.blue,
    ),

    const MessMember(
      name: 'Kanon',
      phone: '01798765432',
      role: 'Member',
      color: Colors.green,
    ),

    const MessMember(
      name: 'Washim',
      phone: '01611223344',
      role: 'Moderator',
      color: Colors.orange,
    ),
  ];

  @override
  void dispose() {
    _memberScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      const SizedBox(height: 10),

                      /// COMBINED MEMBER SECTION
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF141425),

                          borderRadius: BorderRadius.circular(34),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.32),
                              blurRadius: 45,
                              offset: const Offset(0, 14),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [
                            /// TAB BAR
                            Container(
                              padding: const EdgeInsets.all(8),

                              decoration: BoxDecoration(
                                color: const Color(0xFF111120),

                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(34),
                                  topRight: Radius.circular(34),
                                ),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.40),
                                    blurRadius: 35,
                                    offset: const Offset(0, 12),
                                  ),
                                ],
                              ),

                              child: Row(
                                children: [
                                  /// ACTIVE MEMBERS TAB
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),

                                      decoration: const BoxDecoration(
                                        color: Color(0xFF171727),

                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(22),
                                          topRight: Radius.circular(22),
                                        ),
                                      ),

                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        mainAxisSize: MainAxisSize.min,

                                        children: [
                                          const Text(
                                            'Members',

                                            overflow: TextOverflow.ellipsis,

                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(height: 1),

                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.people,
                                                color: Colors.white54,
                                                size: 11,
                                              ),

                                              const SizedBox(width: 5),

                                              Text(
                                                '${members.length}',

                                                style: const TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  /// ADD MEMBER TAB
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        _showAddMemberDialog(context);
                                      },

                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 18,
                                        ),

                                        decoration: BoxDecoration(
                                          color: const Color(0xFF5B55A3),

                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),

                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,

                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 18,
                                            ),

                                            SizedBox(width: 8),

                                            Flexible(
                                              child: Text(
                                                'Add Member',

                                                overflow: TextOverflow.ellipsis,

                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// MEMBER LIST
                            Container(
                              height: 320,

                              padding: const EdgeInsets.fromLTRB(
                                20,
                                12,
                                20,
                                20,
                              ),

                              child: RawScrollbar(
                                controller: _memberScrollController,

                                thumbColor: const Color(0xFF5B55A3),

                                trackColor: Colors.white10,

                                radius: const Radius.circular(20),

                                thickness: 3,

                                thumbVisibility: true,

                                trackVisibility: true,

                                child: ListView.separated(
                                  controller: _memberScrollController,

                                  physics:
                                      const AlwaysScrollableScrollPhysics(),

                                  itemCount: members.length,

                                  separatorBuilder: (_, _) =>
                                      const SizedBox(height: 16),

                                  itemBuilder: (context, index) {
                                    final member = members[index];

                                    return _memberTile(
                                      name: member.name,

                                      phone: member.phone,

                                      role: member.role,

                                      color: member.color,
                                    );
                                  },
                                ),
                              ),
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

                        childAspectRatio: 1.05,

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

                        childAspectRatio: 1.05,

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
  required String phone,
  required String role,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),

    decoration: BoxDecoration(
      color: const Color(0xFF111120),

      borderRadius: BorderRadius.circular(24),
    ),

    child: Row(
      children: [
        CircleAvatar(
          radius: 24,

          backgroundColor: color,

          child: Text(
            name.substring(0, 1),

            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      name,

                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),

                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),

                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Text(
                      role,

                      style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              Text(
                phone,

                style: const TextStyle(color: Colors.white54, fontSize: 12),
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

            const PopupMenuItem(value: 'copy', child: Text('Copy Number')),

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
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: color.withOpacity(0.15),

              borderRadius: BorderRadius.circular(16),
            ),

            child: Icon(icon, color: color, size: 20),
          ),
        ),

        Expanded(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

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

              child: FittedBox(
                fit: BoxFit.scaleDown,

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      amount,

                      style: const TextStyle(
                        color: Colors.white,

                        fontSize: 22,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      title,

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
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
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: color.withOpacity(0.15),

              borderRadius: BorderRadius.circular(16),
            ),

            child: Icon(icon, color: color, size: 20),
          ),
        ),

        Expanded(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

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

              child: FittedBox(
                fit: BoxFit.scaleDown,

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      value,

                      style: const TextStyle(
                        color: Colors.white,

                        fontSize: 22,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      title,

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
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

void _showAddMemberDialog(BuildContext context) {
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  String selectedRole = 'Member';

  showDialog(
    context: context,

    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            backgroundColor: const Color(0xFF171727),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),

            title: const Text(
              'Add Member',

              style: TextStyle(color: Colors.white),
            ),

            content: SizedBox(
              width: 420,

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  TextField(
                    controller: nameController,

                    style: const TextStyle(color: Colors.white),

                    decoration: const InputDecoration(labelText: 'Name'),
                  ),

                  const SizedBox(height: 18),

                  TextField(
                    controller: phoneController,

                    keyboardType: TextInputType.phone,

                    style: const TextStyle(color: Colors.white),

                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),

                  const SizedBox(height: 18),

                  DropdownButtonFormField<String>(
                    initialValue: selectedRole,

                    dropdownColor: const Color(0xFF171727),

                    items: const [
                      DropdownMenuItem(value: 'Member', child: Text('Member')),

                      DropdownMenuItem(
                        value: 'Moderator',
                        child: Text('Moderator'),
                      ),

                      DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                    ],

                    onChanged: (value) {
                      setStateDialog(() {
                        selectedRole = value!;
                      });
                    },
                  ),
                ],
              ),
            ),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text('Cancel'),
              ),

              FilledButton(
                onPressed: () {
                  final generatedPassword = DateTime.now()
                      .millisecondsSinceEpoch
                      .toString()
                      .substring(7);

                  debugPrint('Generated Password: $generatedPassword');

                  Navigator.pop(context);
                },

                child: const Text('Add Member'),
              ),
            ],
          );
        },
      );
    },
  );
}
