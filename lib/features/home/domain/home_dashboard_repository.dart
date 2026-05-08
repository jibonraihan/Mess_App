import 'home_dashboard.dart';

abstract class HomeDashboardRepository {
  Future<DashboardSnapshot> fetchDashboardSnapshot();
}
