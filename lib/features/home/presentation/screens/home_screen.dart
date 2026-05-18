import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../mess/application/mess_controller.dart';
import '../../../mess/domain/mess.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/services.dart';
import '../../../../core/shared/bazaar_list_store.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime today = DateTime.now();

  final Map<DateTime, String> bazaarDuty = {
    DateTime.utc(2026, 5, 13): 'Raihan',

    DateTime.utc(2026, 5, 14): 'Sakib',

    DateTime.utc(2026, 5, 15): 'Tanvir',

    DateTime.utc(2026, 5, 16): 'Nabil',
  };
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
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        body: Center(
          child: Text(
            'No mess data',

            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      );
    }

    final currentMess = mess!;

    final messName = currentMess.name;

    final messDescription =
        currentMess.description != null &&
            currentMess.description!.trim().isNotEmpty
        ? currentMess.description!
        : 'No description yet';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP SECTION
              // TOP SECTION
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    messName,

                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Welcome back, Everyone 👋',

                    style: TextStyle(color: Colors.grey.shade400, fontSize: 18),
                  ),

                  const SizedBox(height: 24),

                  /// PROFILE CARD
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(28),

                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF171727)
                          : Colors.white,

                      borderRadius: BorderRadius.circular(30),

                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black.withOpacity(0.32)
                              : Colors.black.withOpacity(0.08),

                          blurRadius: 26,

                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),

                    child: Column(
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

                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),

                          child: Text(
                            messDescription,

                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        ElevatedButton.icon(
                          onPressed: () {
                            final nameController = TextEditingController(
                              text: messName,
                            );

                            final descriptionController = TextEditingController(
                              text: messDescription,
                            );

                            Uint8List? selectedAvatar = mess?.avatarBytes;
                            bool avatarRemoved = selectedAvatar == null;

                            showDialog(
                              context: context,

                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setStateDialog) {
                                    return AlertDialog(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).cardColor,

                                      title: Center(
                                        child: Text(
                                          'Edit Mess Profile',

                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),

                                      content: SizedBox(
                                        width: 400,

                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,

                                          children: [
                                            /// PROFILE IMAGE
                                            GestureDetector(
                                              onTap: () async {
                                                await showModalBottomSheet(
                                                  context: context,

                                                  backgroundColor:
                                                      Colors.transparent,

                                                  barrierColor: Colors.black54,

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
                                                            color: Theme.of(
                                                              context,
                                                            ).cardColor,

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
                                                              /// SEE PHOTO
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

                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                        context,
                                                                      );

                                                                      showDialog(
                                                                        context:
                                                                            context,

                                                                        builder: (_) {
                                                                          return Dialog(
                                                                            backgroundColor:
                                                                                Colors.transparent,

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
                                                                        color: Colors
                                                                            .white,
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

                                                              /// CHOOSE / UPDATE PHOTO
                                                              Material(
                                                                color: Colors
                                                                    .transparent,

                                                                child: InkWell(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        18,
                                                                      ),

                                                                  onTap: () async {
                                                                    Navigator.pop(
                                                                      context,
                                                                    );

                                                                    final picker =
                                                                        ImagePicker();

                                                                    final image =
                                                                        await picker.pickImage(
                                                                          source:
                                                                              ImageSource.gallery,
                                                                        );

                                                                    if (image !=
                                                                        null) {
                                                                      final bytes =
                                                                          await image
                                                                              .readAsBytes();

                                                                      setStateDialog(() {
                                                                        selectedAvatar =
                                                                            bytes;
                                                                        avatarRemoved =
                                                                            false;
                                                                      });
                                                                    }
                                                                  },

                                                                  child: ListTile(
                                                                    leading: const Icon(
                                                                      Icons
                                                                          .photo_library,
                                                                      color: Colors
                                                                          .white,
                                                                    ),

                                                                    title: Text(
                                                                      selectedAvatar ==
                                                                              null
                                                                          ? 'Choose Photo'
                                                                          : 'Update Photo',

                                                                      style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              /// REMOVE PHOTO
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

                                                                    onTap: () {
                                                                      /// CLOSE ONLY BOTTOM SHEET
                                                                      Navigator.of(
                                                                        context,
                                                                      ).pop();

                                                                      /// ONLY UPDATE DIALOG STATE
                                                                      setStateDialog(() {
                                                                        selectedAvatar =
                                                                            null;
                                                                        avatarRemoved =
                                                                            true;
                                                                      });
                                                                    },

                                                                    child: const ListTile(
                                                                      leading: Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .red,
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

                                            /// NAME FIELD
                                            TextField(
                                              controller: nameController,

                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                              ),

                                              decoration: InputDecoration(
                                                labelText: 'Mess Name',

                                                labelStyle: TextStyle(
                                                  color: Colors.grey.shade400,
                                                ),

                                                filled: true,

                                                fillColor:
                                                    Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? const Color(0xFF1B1B2D)
                                                    : const Color(0xFFF2EFF8),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            18,
                                                          ),

                                                      borderSide:
                                                          BorderSide.none,
                                                    ),

                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            18,
                                                          ),

                                                      borderSide:
                                                          const BorderSide(
                                                            color: Color(
                                                              0xFF5B55A3,
                                                            ),
                                                            width: 2,
                                                          ),
                                                    ),
                                              ),
                                            ),

                                            const SizedBox(height: 20),

                                            /// DESCRIPTION FIELD
                                            TextField(
                                              controller: descriptionController,

                                              maxLines: 3,

                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                              ),

                                              decoration: InputDecoration(
                                                labelText: 'Description',

                                                labelStyle: TextStyle(
                                                  color: Colors.grey.shade400,
                                                ),

                                                filled: true,

                                                fillColor:
                                                    Theme.of(
                                                          context,
                                                        ).brightness ==
                                                        Brightness.dark
                                                    ? const Color(0xFF1B1B2D)
                                                    : const Color(0xFFF2EFF8),

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            18,
                                                          ),

                                                      borderSide:
                                                          BorderSide.none,
                                                    ),

                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            18,
                                                          ),

                                                      borderSide:
                                                          const BorderSide(
                                                            color: Color(
                                                              0xFF5B55A3,
                                                            ),
                                                            width: 2,
                                                          ),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      actions: [
                                        /// CANCEL
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },

                                          child: const Text('Cancel'),
                                        ),

                                        /// SAVE
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF5B55A3,
                                            ),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),

                                          onPressed: () async {
                                            await ref
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

                                                  removeAvatar: avatarRemoved,
                                                );

                                            if (context.mounted) {
                                              Navigator.pop(context);
                                            }
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
                            foregroundColor: Colors.white,

                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),

                          icon: const Icon(Icons.edit),

                          label: const FittedBox(
                            fit: BoxFit.scaleDown,

                            child: Text('Edit Profile', maxLines: 1),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// ALL 8 CARDS
                  GridView.count(
                    crossAxisCount: 4,

                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,

                    childAspectRatio: 0.95,

                    children: const [
                      _QuickActionCard(
                        title: 'Members',
                        icon: Icons.group,
                        value: '12',
                      ),

                      _QuickActionCard(
                        title: 'Today Meals',
                        icon: Icons.restaurant,
                        value: '26',
                      ),

                      _QuickActionCard(
                        title: 'Balance',
                        icon: Icons.account_balance_wallet,
                        value: '৳ 12,500',
                      ),

                      _QuickActionCard(
                        title: 'Expenses',
                        icon: Icons.bar_chart,
                        value: '৳ 4,200',
                      ),

                      _QuickActionCard(
                        title: 'Add Meal',
                        icon: Icons.restaurant_menu,
                      ),

                      _QuickActionCard(
                        title: 'Add Expense',
                        icon: Icons.payments,
                      ),

                      _QuickActionCard(title: 'Open Chat', icon: Icons.chat),

                      _QuickActionCard(
                        title: 'Invite Member',
                        icon: Icons.person_add,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF171727)
                      : Colors.white,

                  borderRadius: BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.30)
                          : Colors.black.withOpacity(0.07),

                      blurRadius: 24,

                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Bazaar Calendar',

                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    TableCalendar(
                      focusedDay: today,

                      firstDay: DateTime.utc(2020),
                      lastDay: DateTime.utc(2035),

                      calendarFormat: CalendarFormat.month,

                      headerStyle: HeaderStyle(
                        titleTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),

                        formatButtonVisible: false,

                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),

                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),

                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.7),
                        ),

                        weekendStyle: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),

                      calendarStyle: CalendarStyle(
                        cellMargin: const EdgeInsets.all(6),

                        cellPadding: const EdgeInsets.all(0),
                        defaultTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),

                        weekendTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),

                        todayDecoration: BoxDecoration(
                          color: const Color(0xFF5B55A3),

                          borderRadius: BorderRadius.circular(16),

                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF5B55A3).withOpacity(0.45),

                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),

                        todayTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      calendarBuilders: CalendarBuilders(
                        todayBuilder: (context, day, focusedDay) {
                          final normalizedDay = DateTime.utc(
                            day.year,
                            day.month,
                            day.day,
                          );

                          final memberName = bazaarDuty[normalizedDay];

                          return Container(
                            width: double.infinity,
                            height: 56,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 4,
                            ),

                            decoration: BoxDecoration(
                              color: const Color(0xFF5B55A3),

                              borderRadius: BorderRadius.circular(20),

                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    255,
                                    1,
                                    58,
                                    92,
                                  ).withOpacity(0.35),

                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text(
                                  '${day.day}',

                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                if (memberName != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),

                                    child: Text(
                                      memberName,

                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,

                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                        defaultBuilder: (context, day, focusedDay) {
                          //final isToday = isSameDay(day, today);
                          final normalizedDay = DateTime.utc(
                            day.year,
                            day.month,
                            day.day,
                          );

                          final memberName = bazaarDuty[normalizedDay];

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 180),

                            margin: const EdgeInsets.all(4),

                            decoration: BoxDecoration(
                              color: isSameDay(day, today)
                                  ? const Color(0xFF6C63FF)
                                  : Colors.transparent,

                              borderRadius: BorderRadius.circular(16),

                              boxShadow: isSameDay(day, today)
                                  ? [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF6C63FF,
                                        ).withOpacity(0.35),

                                        blurRadius: 12,

                                        offset: const Offset(0, 5),
                                      ),
                                    ]
                                  : null,
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text(
                                  '${day.day}',

                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),

                                if (memberName != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),

                                    child: Text(
                                      memberName,

                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,

                                      style: TextStyle(
                                        color: isSameDay(day, today)
                                            ? Colors.white
                                            : const Color(0xFF8B80F8),

                                        fontSize: isSameDay(day, today)
                                            ? 11
                                            : 10,

                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ValueListenableBuilder(
                valueListenable: todaysBazaarList,

                builder: (context, value, _) {
                  return Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(24),

                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF171727)
                          : Colors.white,

                      borderRadius: BorderRadius.circular(30),

                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black.withOpacity(0.28)
                              : Colors.black.withOpacity(0.06),

                          blurRadius: 24,

                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    "Today's bazar list",

                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,

                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  ValueListenableBuilder(
                                    valueListenable: bazaarListUpdatedAt,

                                    builder: (context, updatedAt, _) {
                                      if (updatedAt == null) {
                                        return const SizedBox();
                                      }

                                      final months = [
                                        'Jan',
                                        'Feb',
                                        'Mar',
                                        'Apr',
                                        'May',
                                        'Jun',
                                        'Jul',
                                        'Aug',
                                        'Sep',
                                        'Oct',
                                        'Nov',
                                        'Dec',
                                      ];

                                      final hour = updatedAt.hour > 12
                                          ? updatedAt.hour - 12
                                          : updatedAt.hour;

                                      final minute = updatedAt.minute
                                          .toString()
                                          .padLeft(2, '0');

                                      final ampm = updatedAt.hour >= 12
                                          ? 'pm'
                                          : 'am';

                                      final formatted =
                                          '${updatedAt.day} '
                                          '${months[updatedAt.month - 1]}, '
                                          '$hour:$minute $ampm';

                                      return Text(
                                        'Updated: $formatted',

                                        style: TextStyle(
                                          fontSize: 12,

                                          color:
                                              Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white54
                                              : Colors.black54,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(text: value),
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Copied to clipboard'),
                                  ),
                                );
                              },

                              icon: Icon(
                                Icons.copy_rounded,

                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        Text(
                          value.trim().isEmpty
                              ? 'No bazar list published'
                              : value,

                          style: TextStyle(
                            height: 1.7,

                            fontSize: 16,

                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
              // MEMBERS
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF171727)
                      : Colors.white,

                  borderRadius: BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.30)
                          : Colors.black.withOpacity(0.07),

                      blurRadius: 24,

                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Mess Members',

                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 24),

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
        color: Theme.of(context).cardColor,

        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Icon(icon, color: const Color(0xFF8E87FD), size: 32),

          const SizedBox(height: 20),

          Text(
            value,

            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
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
  final String? value;

  const _QuickActionCard({required this.title, required this.icon, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF171727)
            : Colors.white,

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.24)
                : Colors.black.withOpacity(0.06),

            blurRadius: 16,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),

        child: FittedBox(
          fit: BoxFit.scaleDown,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(icon, color: const Color(0xFF8B80F8), size: 24),

              const SizedBox(height: 8),

              if (value != null)
                Text(
                  value!,

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              if (value != null) const SizedBox(height: 4),

              SizedBox(
                width: 80,

                child: Text(
                  title,

                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
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
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF0F0F1B)
            : const Color(0xFFF4F2FA),

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.18)
                : Colors.black.withOpacity(0.04),

            blurRadius: 12,

            offset: const Offset(0, 4),
          ),
        ],
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

              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18,
              ),
            ),
          ),

          Text(
            role,

            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
