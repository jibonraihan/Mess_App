import 'package:flutter/material.dart';
import '../../domain/meals_domain.dart';

class MealStatusCard extends StatelessWidget {
  const MealStatusCard({required this.item, required this.onToggle, super.key});

  final DailyMealStatus item;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF171727)
            : const Color(0xFFF1EEF7),

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),

            blurRadius: 18,

            offset: const Offset(0, 8),
          ),
        ],

        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
