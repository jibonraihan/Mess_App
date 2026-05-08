import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/meals_controller.dart';
import '../widgets/meal_dashboard_card.dart';
import '../widgets/member_meal_tile.dart';

class MealHistoryScreen extends ConsumerWidget {
  const MealHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(mealsControllerProvider).data;
    if (data == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Meal History')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          MealDashboardCard(
            title: 'Member-wise meal history',
            child: Column(
              children: data.memberHistory
                  .map((item) => MemberMealTile(item: item))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
