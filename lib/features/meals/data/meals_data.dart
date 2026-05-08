import '../domain/meals_domain.dart';

class MealsRepositoryImpl implements MealsRepository {
  // Replace this mock repository with Supabase-backed data source later.
  final List<DailyMealStatus> _todayMealStatus = [
    const DailyMealStatus(type: MealType.breakfast, totalCount: 21, isActive: true),
    const DailyMealStatus(type: MealType.lunch, totalCount: 26, isActive: true),
    const DailyMealStatus(type: MealType.dinner, totalCount: 24, isActive: false),
  ];

  @override
  Future<MealDashboardData> fetchDashboard() async {
    await Future<void>.delayed(const Duration(milliseconds: 360));

    const members = [
      MemberMealHistory(
        memberName: 'Rahim',
        breakfastCount: 18,
        lunchCount: 26,
        dinnerCount: 22,
        monthlyTotal: 66,
      ),
      MemberMealHistory(
        memberName: 'Karim',
        breakfastCount: 16,
        lunchCount: 24,
        dinnerCount: 20,
        monthlyTotal: 60,
      ),
      MemberMealHistory(
        memberName: 'Sakib',
        breakfastCount: 14,
        lunchCount: 22,
        dinnerCount: 19,
        monthlyTotal: 55,
      ),
      MemberMealHistory(
        memberName: 'Jamal',
        breakfastCount: 13,
        lunchCount: 20,
        dinnerCount: 18,
        monthlyTotal: 51,
      ),
      MemberMealHistory(
        memberName: 'Tanjim',
        breakfastCount: 12,
        lunchCount: 18,
        dinnerCount: 17,
        monthlyTotal: 47,
      ),
    ];

    return MealDashboardData(
      todayMeals: List.unmodifiable(_todayMealStatus),
      todayMenu: const [
        MealMenuItem(type: MealType.breakfast, menu: 'Paratha, egg bhaji, tea'),
        MealMenuItem(type: MealType.lunch, menu: 'Rice, fish curry, lentil, salad'),
        MealMenuItem(type: MealType.dinner, menu: 'Khichuri, chicken roast, cucumber'),
      ],
      stats: MealStats(
        totalMonthlyMeals: members.fold<int>(0, (sum, item) => sum + item.monthlyTotal),
        costPerMeal: 54.75,
        topConsumers: members.take(3).toList(),
        attendanceRate: 0.86,
      ),
      memberHistory: members,
      activities: const [
        MealActivity(
          title: 'Lunch attendance updated',
          subtitle: '26 confirmed meals',
          time: '35 mins ago',
        ),
        MealActivity(
          title: 'Dinner temporarily paused',
          subtitle: 'Admin turned off dinner toggle',
          time: '1 hr ago',
        ),
        MealActivity(
          title: 'Menu revised',
          subtitle: 'Dinner menu changed for tomorrow',
          time: '3 hrs ago',
        ),
      ],
      schedule: const [
        UpcomingMealSchedule(
          dayLabel: 'Tomorrow',
          breakfast: 'Khichuri + egg',
          lunch: 'Rice + beef curry',
          dinner: 'Noodles + chicken fry',
        ),
        UpcomingMealSchedule(
          dayLabel: 'Sunday',
          breakfast: 'Bread + jam + omelette',
          lunch: 'Polao + roast',
          dinner: 'Rice + daal + fish',
        ),
      ],
      adminControlsEnabled: true,
    );
  }

  @override
  Future<void> toggleMealStatus(MealType type, bool active) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _todayMealStatus.indexWhere((item) => item.type == type);
    if (index == -1) return;
    final current = _todayMealStatus[index];
    _todayMealStatus[index] = DailyMealStatus(
      type: current.type,
      totalCount: current.totalCount,
      isActive: active,
    );
  }
}
