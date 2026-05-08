import 'package:flutter/material.dart';

class MemberAvatarRow extends StatelessWidget {
  const MemberAvatarRow({super.key});

  @override
  Widget build(BuildContext context) {
    final members = List.generate(
      12,
      (index) => {
        'name': 'Member ${index + 1}',
        'online': index % 2 == 0,
      },
    );

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: members.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final member = members[index];

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      child: Text(
                        member['name']!
                            .toString()
                            .substring(0, 1),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: member['online'] as bool
                              ? Colors.green
                              : Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context)
                                .scaffoldBackgroundColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  member['name']!.toString(),
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}