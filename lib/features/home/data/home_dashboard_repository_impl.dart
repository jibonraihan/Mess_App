import '../domain/home_dashboard.dart';
import '../domain/home_dashboard_repository.dart';

class HomeDashboardRepositoryImpl implements HomeDashboardRepository {
  @override
  Future<DashboardSnapshot> fetchDashboardSnapshot() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return const DashboardSnapshot(
      currentBalance: 18540,
      monthlyExpense: 12480,
      pendingDues: 3200,
      todayMeal: 'Rice, Chicken Curry, Lentil, Salad',
      upcomingMarketDuty: 'Rahim - Friday, 9:30 AM',
      stats: [
        DashboardStat(label: 'Residents', value: '28', delta: '+2 this month'),
        DashboardStat(label: 'Meals Served', value: '842', delta: '+6.4%'),
        DashboardStat(label: 'Collections', value: '৳64.2K', delta: '+11%'),
        DashboardStat(label: 'Pending Bills', value: '9', delta: '-3 this week'),
      ],
      activities: [
        ActivityItem(
          title: 'Expense Added',
          subtitle: 'Vegetable market - ৳2,350',
          time: '10 mins ago',
        ),
        ActivityItem(
          title: 'Payment Received',
          subtitle: 'Sakib cleared due - ৳1,200',
          time: '45 mins ago',
        ),
        ActivityItem(
          title: 'Meal Updated',
          subtitle: 'Dinner menu changed for Saturday',
          time: '2 hrs ago',
        ),
        ActivityItem(
          title: 'New Member Joined',
          subtitle: 'Tanjim added to Member role',
          time: 'Today',
        ),
      ],
      adminNotices: [
        AdminNotice(
          title: 'Utility Bill Reminder',
          message: 'Electricity bill due on 12 May. Please clear dues before then.',
        ),
        AdminNotice(
          title: 'Monthly Meeting',
          message: 'Management meeting this Sunday at 8:30 PM in dining room.',
        ),
      ],
    );
  }
}
