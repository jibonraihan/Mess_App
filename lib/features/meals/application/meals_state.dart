import '../domain/meals_domain.dart';

class MealsState {
  const MealsState({
    this.data,
    this.isLoading = false,
    this.errorMessage,
  });

  final MealDashboardData? data;
  final bool isLoading;
  final String? errorMessage;

  MealsState copyWith({
    MealDashboardData? data,
    bool clearData = false,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return MealsState(
      data: clearData ? null : (data ?? this.data),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
