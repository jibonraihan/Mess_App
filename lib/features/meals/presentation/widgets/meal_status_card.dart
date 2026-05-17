import 'package:flutter/material.dart';
import '../../domain/meals_domain.dart';

class MealStatusCard extends StatelessWidget {
  const MealStatusCard({required this.item, required this.onToggle, super.key});

  final DailyMealStatus item;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    _label(item.type),

                    style: Theme.of(context).textTheme.titleSmall,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Count: ${item.totalCount}',

                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Switch.adaptive(value: item.isActive, onChanged: onToggle),
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
