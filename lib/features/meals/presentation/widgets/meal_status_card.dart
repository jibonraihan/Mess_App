import 'package:flutter/material.dart';
import '../../domain/meals_domain.dart';

class MealStatusCard extends StatelessWidget {
  const MealStatusCard({
    required this.item,
    required this.onToggle,
    super.key,
  });

  final DailyMealStatus item;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_label(item.type), style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Text('Count: ${item.totalCount}'),
            const SizedBox(height: 8),
            Switch.adaptive(
              value: item.isActive,
              onChanged: onToggle,
            ),
          ],
        ),
      ),
    );
  }

  String _label(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
    }
  }
}
