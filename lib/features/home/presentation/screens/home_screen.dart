import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../mess/application/mess_controller.dart';
import '../../../mess/domain/mess.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final messState = ref.watch(messControllerProvider);

    Mess? mess;

messState.maybeWhen(
  loaded: (loadedMess) {
    mess = loadedMess;
  },
  orElse: () {},
);
   if (mess == null) {
  return const Scaffold(
    backgroundColor: Color(0xFF0B0B16),

    body: Center(
      child: Text(
        'No mess data',

        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

    final currentMess = mess!;

final messName =
    currentMess.name;

final messDescription =
    currentMess.description != null &&
            currentMess.description!
                .trim()
                .isNotEmpty
        ? currentMess.description!
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
                  // LEFT SIDE
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

                  // RIGHT SIDE
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

                            backgroundImage: mess?.avatarBytes != null
                                ? MemoryImage(mess!.avatarBytes!)
                                : null,

                            child: mess?.avatarBytes == null
                                ? Text(
                                    messName.substring(0, 1).toUpperCase(),

                                    style: const TextStyle(
                                      fontSize: 52,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),

                            child: Text(
                              messDescription,

                              textAlign: TextAlign.center,

                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                          ),

                          const SizedBox(height: 24),

                          ElevatedButton.icon(
                            onPressed: () {
                              final nameController = TextEditingController(
                                text: messName,
                              );

                              final descriptionController =
                                  TextEditingController(text: messDescription);

                              Uint8List? selectedAvatar = mess?.avatarBytes;

                              showDialog(
                                context: context,

                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setStateDialog) {
                                      return AlertDialog(
                                        backgroundColor: const Color(
                                          0xFF171727,
                                        ),

                                        title: const Text(
                                          'Edit Mess Profile',

                                          style: TextStyle(color: Colors.white),
                                        ),

                                        content: SizedBox(
                                          width: 400,

                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,

                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    context: context,

                                                    backgroundColor:
                                                        Colors.transparent,

                                                    barrierColor:
                                                        Colors.black54,

                                                    isScrollControlled: true,

                                                    builder: (context) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                              left: 24,
                                                              right: 24,
                                                              bottom: 120,
                                                            ),

                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomCenter,

                                                          child: Container(
                                                            width: 360,

                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  vertical: 10,
                                                                ),

                                                            decoration: BoxDecoration(
                                                              color:
                                                                  const Color(
                                                                    0xFF171727,
                                                                  ),

                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    28,
                                                                  ),
                                                            ),

                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,

                                                              children: [
                                                                if (selectedAvatar !=
                                                                    null)
                                                                  Material(
                                                                    color: Colors
                                                                        .transparent,

                                                                    child: InkWell(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            18,
                                                                          ),

                                                                      splashColor:
                                                                          const Color(
                                                                            0xFF5B55A3,
                                                                          ).withOpacity(
                                                                            0.25,
                                                                          ),

                                                                      highlightColor:
                                                                          const Color(
                                                                            0xFF5B55A3,
                                                                          ).withOpacity(
                                                                            0.12,
                                                                          ),

                                                                      onTap: () {
                                                                        Navigator.pop(
                                                                          context,
                                                                        );

                                                                        showDialog(
                                                                          context:
                                                                              context,

                                                                          builder: (_) {
                                                                            return Dialog(
                                                                              backgroundColor: Colors.transparent,

                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(
                                                                                  24,
                                                                                ),

                                                                                child: Image.memory(
                                                                                  selectedAvatar!,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },

                                                                      child: const ListTile(
                                                                        leading: Icon(
                                                                          Icons
                                                                              .image,
                                                                          color:
                                                                              Colors.white,
                                                                        ),

                                                                        title: Text(
                                                                          'See Photo',

                                                                          style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                Material(
                                                                  color: Colors
                                                                      .transparent,

                                                                  child: InkWell(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          18,
                                                                        ),

                                                                    splashColor:
                                                                        const Color(
                                                                          0xFF5B55A3,
                                                                        ).withOpacity(
                                                                          0.25,
                                                                        ),

                                                                    highlightColor:
                                                                        const Color(
                                                                          0xFF5B55A3,
                                                                        ).withOpacity(
                                                                          0.12,
                                                                        ),

                                                                    onTap: () async {
                                                                      Navigator.pop(
                                                                        context,
                                                                      );

                                                                      final picker =
                                                                          ImagePicker();

                                                                      final image = await picker.pickImage(
                                                                        source:
                                                                            ImageSource.gallery,
                                                                      );

                                                                      if (image !=
                                                                          null) {
                                                                        final bytes =
                                                                            await image.readAsBytes();

                                                                        setStateDialog(() {
                                                                          selectedAvatar =
                                                                              bytes;
                                                                        });
                                                                      }
                                                                    },

                                                                    child: const ListTile(
                                                                      leading: Icon(
                                                                        Icons
                                                                            .photo_library,
                                                                        color: Colors
                                                                            .white,
                                                                      ),

                                                                      title: Text(
                                                                        'Choose Photo',

                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                if (selectedAvatar !=
                                                                    null)
                                                                  Material(
                                                                    color: Colors
                                                                        .transparent,

                                                                    child: InkWell(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            18,
                                                                          ),

                                                                      splashColor: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                            0.25,
                                                                          ),

                                                                      highlightColor: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                            0.12,
                                                                          ),

                                                                      onTap: () {
                                                                        Navigator.pop(
                                                                          context,
                                                                        );

                                                                        setStateDialog(() {
                                                                          selectedAvatar =
                                                                              null;
                                                                          ref
                                                                              .read(
                                                                                messControllerProvider.notifier,
                                                                              )
                                                                              .updateMessProfile(
                                                                                name: nameController.text,
                                                                                description: descriptionController.text,
                                                                                removeAvatar: true,
                                                                              );
                                                                        });
                                                                      },

                                                                      child: const ListTile(
                                                                        leading: Icon(
                                                                          Icons
                                                                              .delete,
                                                                          color:
                                                                              Colors.red,
                                                                        ),

                                                                        title: Text(
                                                                          'Remove Photo',

                                                                          style: TextStyle(
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },

                                                child: CircleAvatar(
                                                  radius: 45,

                                                  backgroundColor: const Color(
                                                    0xFF5B55A3,
                                                  ),

                                                  backgroundImage:
                                                      selectedAvatar != null
                                                      ? MemoryImage(
                                                          selectedAvatar!,
                                                        )
                                                      : null,

                                                  child: selectedAvatar == null
                                                      ? const Icon(
                                                          Icons.camera_alt,
                                                          color: Colors.white,
                                                          size: 30,
                                                        )
                                                      : null,
                                                ),
                                              ),

                                              const SizedBox(height: 24),

                                              TextField(
                                                controller: nameController,

                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),

                                                decoration: InputDecoration(
                                                  labelText: 'Mess Name',

                                                  labelStyle: TextStyle(
                                                    color: Colors.grey.shade400,
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
                                                    color: Colors.grey.shade400,
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
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFF5B55A3,
                                              ),

                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                            ),

                                            onPressed: () {
                                              ref
                                                  .read(
                                                    messControllerProvider
                                                        .notifier,
                                                  )
                                                  .updateMessProfile(
                                                    name: nameController.text,

                                                    description:
                                                        descriptionController
                                                            .text,

                                                    avatarBytes: selectedAvatar,
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
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5B55A3),

                              padding: const EdgeInsets.symmetric(
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

                    _MemberTile(name: 'Raihan', role: 'Admin'),

                    _MemberTile(name: 'Sakib', role: 'Member'),

                    _MemberTile(name: 'Tanvir', role: 'Member'),

                    _MemberTile(name: 'Nabil', role: 'Member'),
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
          Icon(icon, color: const Color(0xFF8E87FD), size: 32),

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

            style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _QuickActionCard({required this.title, required this.icon});

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
          Icon(icon, size: 32, color: const Color(0xFF8E87FD)),

          const SizedBox(height: 10),

          Text(
            title,

            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final String name;
  final String role;

  const _MemberTile({required this.name, required this.role});

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

              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),

          Text(
            role,

            style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
