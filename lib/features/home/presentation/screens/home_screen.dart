import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../mess/application/mess_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messState = ref.watch(messControllerProvider);

    final mess = messState.maybeWhen(
      loaded: (mess) => mess,
      orElse: () => null,
    );

    final messName = mess?.name ?? 'My Community';

    final messDescription =
        mess?.description?.trim().isNotEmpty == true
            ? mess!.description!
            : 'No description yet';

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B16),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP SECTION
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEFT
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          messName,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'Welcome back, Admin 👋',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 30),

                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: const [
                            _StatCard(
                              title: 'Members',
                              value: '12',
                              icon: Icons.group,
                            ),

                            _StatCard(
                              title: 'Today Meals',
                              value: '26',
                              icon: Icons.restaurant,
                            ),

                            _StatCard(
                              title: 'Balance',
                              value: '৳ 12,500',
                              icon: Icons.account_balance_wallet,
                            ),

                            _StatCard(
                              title: 'Expenses',
                              value: '৳ 4,200',
                              icon: Icons.bar_chart,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 30),

                  // RIGHT
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 320,

                      decoration: BoxDecoration(
                        color: const Color(0xFF171727),
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: const Color(0xFF5B55A3),

                            child: Text(
                              messName[0].toUpperCase(),
                              style: const TextStyle(
                                fontSize: 52,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          Text(
                            messName,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20),

                            child: Text(
                              messDescription,
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          ElevatedButton.icon(
                            onPressed: () {
                              final nameController =
                                  TextEditingController(
                                text: messName,
                              );

                              final descriptionController =
                                  TextEditingController(
                                text: messDescription,
                              );

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        const Color(0xFF171727),

                                    title: const Text(
                                      'Edit Mess Profile',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),

                                    content: SizedBox(
                                      width: 400,

                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: nameController,

                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),

                                            decoration: InputDecoration(
                                              labelText: 'Mess Name',

                                              labelStyle: TextStyle(
                                                color:
                                                    Colors.grey.shade400,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 20),

                                          TextField(
                                            controller:
                                                descriptionController,

                                            maxLines: 3,

                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),

                                            decoration: InputDecoration(
                                              labelText: 'Description',

                                              labelStyle: TextStyle(
                                                color:
                                                    Colors.grey.shade400,
                                              ),
                                            ),
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

                                      ElevatedButton(
                                        onPressed: () {
                                          ref
                                              .read(
                                                messControllerProvider
                                                    .notifier,
                                              )
                                              .updateMessProfile(
                                                name:
                                                    nameController.text,
                                                description:
                                                    descriptionController
                                                        .text,
                                              );

                                          Navigator.pop(context);
                                        },

                                        child: const Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF5B55A3),

                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                            ),

                            icon: const Icon(Icons.edit),

                            label: const Text('Edit Profile'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // QUICK ACTIONS
              Row(
                children: const [
                  Expanded(
                    child: _QuickActionCard(
                      title: 'Add Meal',
                      icon: Icons.restaurant_menu,
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    child: _QuickActionCard(
                      title: 'Add Expense',
                      icon: Icons.payments,
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    child: _QuickActionCard(
                      title: 'Open Chat',
                      icon: Icons.chat,
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    child: _QuickActionCard(
                      title: 'Invite Member',
                      icon: Icons.person_add,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // MEMBERS
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: const Color(0xFF171727),
                  borderRadius: BorderRadius.circular(30),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Mess Members',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 24),

                    _MemberTile(
                      name: 'Raihan',
                      role: 'Admin',
                    ),

                    _MemberTile(
                      name: 'Sakib',
                      role: 'Member',
                    ),

                    _MemberTile(
                      name: 'Tanvir',
                      role: 'Member',
                    ),

                    _MemberTile(
                      name: 'Nabil',
                      role: 'Member',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFF171727),
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF8E87FD),
            size: 32,
          ),

          const SizedBox(height: 20),

          Text(
            value,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _QuickActionCard({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,

      decoration: BoxDecoration(
        color: const Color(0xFF171727),
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: const Color(0xFF8E87FD),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final String name;
  final String role;

  const _MemberTile({
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1B),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFF5B55A3),

            child: Text(
              name[0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),

          Text(
            role,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}