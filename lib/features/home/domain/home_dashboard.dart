class DashboardSnapshot {
  const DashboardSnapshot({
    required this.currentBalance,
    required this.monthlyExpense,
    required this.pendingDues,
    required this.todayMeal,
    required this.upcomingMarketDuty,
    required this.stats,
    required this.activities,
    required this.adminNotices,
  });

  final double currentBalance;
  final double monthlyExpense;
  final double pendingDues;
  final String todayMeal;
  final String upcomingMarketDuty;
  final List<DashboardStat> stats;
  final List<ActivityItem> activities;
  final List<AdminNotice> adminNotices;
}

class DashboardStat {
  const DashboardStat({
    required this.label,
    required this.value,
    required this.delta,
  });

  final String label;
  final String value;
  final String delta;
}

class ActivityItem {
  const ActivityItem({
    required this.title,
    required this.subtitle,
    required this.time,
  });

  final String title;
  final String subtitle;
  final String time;
}

class AdminNotice {
  const AdminNotice({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;
}
