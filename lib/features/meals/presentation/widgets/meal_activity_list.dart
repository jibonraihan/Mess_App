import 'package:flutter/material.dart';
import '../../domain/meals_domain.dart';

class MealActivityList extends StatelessWidget {
  const MealActivityList({
    required this.items,
    super.key,
  });

  final List<MealActivity> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          _ActivityTile(item: items[i]),
          if (i != items.length - 1) const Divider(height: 16),
        ],
      ],
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.item});

  final MealActivity item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.bolt_rounded, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 2),
              Text(item.subtitle),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(item.time, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
