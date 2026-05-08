import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/meals_controller.dart';
import '../widgets/meal_dashboard_card.dart';
import '../widgets/upcoming_meal_tile.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(mealsControllerProvider).data;
    if (data == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Meal Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          MealDashboardCard(
            title: 'Upcoming meal schedule',
            child: Column(
              children: data.schedule
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: UpcomingMealTile(item: item),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          MealDashboardCard(
            title: "Today's menu details",
            child: Column(
              children: data.todayMenu
                  .map(
                    (item) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(item.type.name.toUpperCase()),
                      subtitle: Text(item.menu),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
