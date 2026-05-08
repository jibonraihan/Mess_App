import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/expenses_data.dart';
import '../domain/expenses_domain.dart';
import 'expenses_state.dart';

final expensesRepositoryProvider = Provider<ExpensesRepository>((ref) {
  return ExpensesRepositoryImpl();
});

final expensesControllerProvider =
    StateNotifierProvider<ExpensesController, ExpensesState>((ref) {
  final repository = ref.watch(expensesRepositoryProvider);
  final controller = ExpensesController(repository);
  controller.load();
  return controller;
});

class ExpensesController extends StateNotifier<ExpensesState> {
  ExpensesController(this._repository) : super(const ExpensesState());

  final ExpensesRepository _repository;

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final data = await _repository.fetchDashboard();
      state = state.copyWith(data: data, isLoading: false);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Could not load expense dashboard.',
      );
    }
  }

  Future<bool> addExpense({
    required String title,
    required double amount,
    required String paidBy,
    required ExpenseCategory category,
    required List<String> splitAmong,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repository.createExpense(
        title: title,
        amount: amount,
        paidBy: paidBy,
        category: category,
        splitAmong: splitAmong,
      );
      final data = await _repository.fetchDashboard();
      state = state.copyWith(data: data, isLoading: false);
      return true;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to add expense.',
      );
      return false;
    }
  }
}
