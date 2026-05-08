import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/home_dashboard_repository_impl.dart';
import '../domain/home_dashboard.dart';
import '../domain/home_dashboard_repository.dart';

final homeDashboardRepositoryProvider = Provider<HomeDashboardRepository>((ref) {
  return HomeDashboardRepositoryImpl();
});

final homeDashboardProvider = FutureProvider<DashboardSnapshot>((ref) async {
  final repository = ref.watch(homeDashboardRepositoryProvider);
  return repository.fetchDashboardSnapshot();
});
