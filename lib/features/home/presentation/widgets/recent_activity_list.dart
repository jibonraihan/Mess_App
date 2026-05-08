import 'package:flutter/material.dart';
import '../../domain/home_dashboard.dart';

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({
    required this.activities,
    super.key,
  });

  final List<ActivityItem> activities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < activities.length; i++) ...[
          _ActivityTile(activity: activities[i]),
          if (i != activities.length - 1) const Divider(height: 18),
        ],
      ],
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.activity});

  final ActivityItem activity;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(activity.title, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 2),
              Text(activity.subtitle),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(activity.time, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
