import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/meals_data.dart';
import '../domain/meals_domain.dart';
import 'meals_state.dart';

final mealsRepositoryProvider = Provider<MealsRepository>((ref) {
  return MealsRepositoryImpl();
});

final mealsControllerProvider =
    StateNotifierProvider<MealsController, MealsState>((ref) {
  final repository = ref.watch(mealsRepositoryProvider);
  final controller = MealsController(repository);
  controller.load();
  return controller;
});

class MealsController extends StateNotifier<MealsState> {
  MealsController(this._repository) : super(const MealsState());

  final MealsRepository _repository;

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final data = await _repository.fetchDashboard();
      state = state.copyWith(data: data, isLoading: false);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load meal dashboard.',
      );
    }
  }

  Future<void> toggleStatus(MealType type, bool active) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repository.toggleMealStatus(type, active);
      final data = await _repository.fetchDashboard();
      state = state.copyWith(data: data, isLoading: false);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Could not update meal status.',
      );
    }
  }
}
