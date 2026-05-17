import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/responsive/responsive_breakpoints.dart';
import '../../application/meals_controller.dart';
import '../../domain/meals_domain.dart';
import '../widgets/meal_activity_list.dart';
import '../widgets/meal_dashboard_card.dart';
import '../widgets/meal_stat_chip.dart';
import '../widgets/meal_status_card.dart';
import '../widgets/member_meal_tile.dart';
import '../widgets/upcoming_meal_tile.dart';

class MealManagementScreen extends ConsumerWidget {
  const MealManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mealsControllerProvider);
    final controller = ref.read(mealsControllerProvider.notifier);
    final data = state.data;
    final isDesktop = ResponsiveBreakpoints.isDesktop(context);
    final screenWidth = MediaQuery.of(context).size.width;

    if (state.isLoading && data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data == null) {
      return Center(
        child: FilledButton.tonal(
          onPressed: controller.load,
          child: const Text('Retry meals'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meal Management',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Daily attendance, menu operations and monthly meal analytics.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              FilledButton.tonalIcon(
                onPressed: () => context.go('/meals/history'),
                icon: const Icon(Icons.history_rounded),
                label: const Text('History'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              MealStatChip(
                icon: Icons.restaurant_rounded,
                label: 'Total monthly meals',
                value: '${data.stats.totalMonthlyMeals}',
              ),
              MealStatChip(
                icon: Icons.currency_exchange_rounded,
                label: 'Cost per meal',
                value: '৳${data.stats.costPerMeal.toStringAsFixed(2)}',
              ),
              MealStatChip(
                icon: Icons.percent_rounded,
                label: 'Attendance rate',
                value:
                    '${(data.stats.attendanceRate * 100).toStringAsFixed(0)}%',
              ),
            ],
          ),
          const SizedBox(height: 12),
          MealDashboardCard(
            title: "Today's meals",
            trailing: state.isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : IconButton(
                    onPressed: controller.load,
                    icon: const Icon(Icons.refresh_rounded),
                  ),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,

              children: data.todayMeals.map((item) {
                final screenWidth = MediaQuery.of(context).size.width;

                final cardWidth = isDesktop
                    ? (screenWidth / 3) - 40
                    : double.infinity;

                return SizedBox(
                  width: cardWidth,

                  child: MealStatusCard(
                    key: ValueKey(
                      '${item.type}-${item.isActive}-${item.totalCount}',
                    ),

                    item: item,

                    onToggle: (active) =>
                        controller.toggleStatus(item.type, active),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MealDashboardCard(
                    title: "Today's food menu",
                    child: Column(
                      children: data.todayMenu
                          .map(
                            (menu) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.food_bank_rounded),
                              title: Text(_mealLabel(menu.type)),
                              subtitle: Text(menu.menu),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MealDashboardCard(
                    title: 'Upcoming meal schedule',
                    trailing: TextButton(
                      onPressed: () => context.go('/meals/details'),
                      child: const Text('Details'),
                    ),
                    child: Column(
                      children: data.schedule
                          .map((item) => UpcomingMealTile(item: item))
                          .toList(),
                    ),
                  ),
                ),
              ],
            )
          else ...[
            MealDashboardCard(
              title: "Today's food menu",
              child: Column(
                children: data.todayMenu
                    .map(
                      (menu) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.food_bank_rounded),
                        title: Text(_mealLabel(menu.type)),
                        subtitle: Text(menu.menu),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            MealDashboardCard(
              title: 'Upcoming meal schedule',
              trailing: TextButton(
                onPressed: () => context.go('/meals/details'),
                child: const Text('Details'),
              ),
              child: Column(
                children: data.schedule
                    .map((item) => UpcomingMealTile(item: item))
                    .toList(),
              ),
            ),
          ],
          const SizedBox(height: 12),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MealDashboardCard(
                    title: 'Top meal consumers',
                    child: Column(
                      children: data.stats.topConsumers
                          .map((item) => MemberMealTile(item: item))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MealDashboardCard(
                    title: 'Recent meal activities',
                    child: MealActivityList(items: data.activities),
                  ),
                ),
              ],
            )
          else ...[
            MealDashboardCard(
              title: 'Top meal consumers',
              child: Column(
                children: data.stats.topConsumers
                    .map((item) => MemberMealTile(item: item))
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            MealDashboardCard(
              title: 'Recent meal activities',
              child: MealActivityList(items: data.activities),
            ),
          ],
          const SizedBox(height: 12),
          MealDashboardCard(
            title: 'Admin meal controls',
            child: _AdminMealControls(enabled: data.adminControlsEnabled),
          ),
        ],
      ),
    );
  }

  static String _mealLabel(MealType type) {
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

class _AdminMealControls extends StatelessWidget {
  const _AdminMealControls({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          value: enabled,
          onChanged: (_) {},
          contentPadding: EdgeInsets.zero,
          title: const Text('Enable admin meal override'),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            Chip(label: Text('Publish Menu')),
            Chip(label: Text('Lock Attendance')),
            Chip(label: Text('Adjust Cost')),
          ],
        ),
      ],
    );
  }
}
