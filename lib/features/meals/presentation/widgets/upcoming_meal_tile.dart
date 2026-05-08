import 'package:flutter/material.dart';
import '../../domain/meals_domain.dart';

class UpcomingMealTile extends StatelessWidget {
  const UpcomingMealTile({
    required this.item,
    super.key,
  });

  final UpcomingMealSchedule item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.dayLabel, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Breakfast: ${item.breakfast}'),
            const SizedBox(height: 4),
            Text('Lunch: ${item.lunch}'),
            const SizedBox(height: 4),
            Text('Dinner: ${item.dinner}'),
          ],
        ),
      ),
    );
  }
}
