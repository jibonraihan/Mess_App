enum MealType { breakfast, lunch, dinner }

class DailyMealStatus {
  const DailyMealStatus({
    required this.type,
    required this.totalCount,
    required this.isActive,
  });

  final MealType type;
  final int totalCount;
  final bool isActive;
}

class MealMenuItem {
  const MealMenuItem({
    required this.type,
    required this.menu,
  });

  final MealType type;
  final String menu;
}

class MemberMealHistory {
  const MemberMealHistory({
    required this.memberName,
    required this.breakfastCount,
    required this.lunchCount,
    required this.dinnerCount,
    required this.monthlyTotal,
  });

  final String memberName;
  final int breakfastCount;
  final int lunchCount;
  final int dinnerCount;
  final int monthlyTotal;
}

class MealActivity {
  const MealActivity({
    required this.title,
    required this.subtitle,
    required this.time,
  });

  final String title;
  final String subtitle;
  final String time;
}

class UpcomingMealSchedule {
  const UpcomingMealSchedule({
    required this.dayLabel,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  final String dayLabel;
  final String breakfast;
  final String lunch;
  final String dinner;
}

class MealStats {
  const MealStats({
    required this.totalMonthlyMeals,
    required this.costPerMeal,
    required this.topConsumers,
    required this.attendanceRate,
  });

  final int totalMonthlyMeals;
  final double costPerMeal;
  final List<MemberMealHistory> topConsumers;
  final double attendanceRate;
}

class MealDashboardData {
  const MealDashboardData({
    required this.todayMeals,
    required this.todayMenu,
    required this.stats,
    required this.memberHistory,
    required this.activities,
    required this.schedule,
    required this.adminControlsEnabled,
  });

  final List<DailyMealStatus> todayMeals;
  final List<MealMenuItem> todayMenu;
  final MealStats stats;
  final List<MemberMealHistory> memberHistory;
  final List<MealActivity> activities;
  final List<UpcomingMealSchedule> schedule;
  final bool adminControlsEnabled;
}

abstract class MealsRepository {
  Future<MealDashboardData> fetchDashboard();

  Future<void> toggleMealStatus(MealType type, bool active);
}
