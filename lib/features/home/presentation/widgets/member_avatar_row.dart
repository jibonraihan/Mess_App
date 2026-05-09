import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/widgets/avatar_image.dart';

class MemberAvatar {
  final String id;
  final String name;
  final String? imageUrl;
  final bool isOnline;

  const MemberAvatar({
    required this.id,
    required this.name,
    this.imageUrl,
    this.isOnline = false,
  });
}

class MemberAvatarRow extends StatelessWidget {
  const MemberAvatarRow({super.key, required this.members, this.onMemberTap});

  final List<MemberAvatar> members;
  final Function(MemberAvatar)? onMemberTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Members',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to full members list
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: members.length,
            separatorBuilder: (context, index) => const Gap(16),
            itemBuilder: (context, index) {
              final member = members[index];
              return GestureDetector(
                onTap: () => onMemberTap?.call(member),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        AvatarImage(
                          imageBytes: null,
                          radius: 20,
                          fallbackText: member.name,
                        ),
                        if (member.isOnline)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: colorScheme.surface,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Gap(8),
                    SizedBox(
                      width: 60,
                      child: Text(
                        member.name,
                        style: textTheme.labelSmall,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Mock member data for demonstration
final mockMembers = [
  const MemberAvatar(id: '1', name: 'Alice', isOnline: true),
  const MemberAvatar(id: '2', name: 'Bob', isOnline: false),
  const MemberAvatar(id: '3', name: 'Charlie', isOnline: true),
  const MemberAvatar(id: '4', name: 'David', isOnline: false),
  const MemberAvatar(id: '5', name: 'Eve', isOnline: true),
  const MemberAvatar(id: '6', name: 'Frank', isOnline: true),
  const MemberAvatar(id: '7', name: 'Grace', isOnline: false),
];
