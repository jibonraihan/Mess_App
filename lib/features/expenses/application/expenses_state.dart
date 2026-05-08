import '../domain/expenses_domain.dart';

class ExpensesState {
  const ExpensesState({
    this.data,
    this.isLoading = false,
    this.errorMessage,
  });

  final ExpenseDashboardData? data;
  final bool isLoading;
  final String? errorMessage;

  ExpensesState copyWith({
    ExpenseDashboardData? data,
    bool clearData = false,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ExpensesState(
      data: clearData ? null : (data ?? this.data),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
