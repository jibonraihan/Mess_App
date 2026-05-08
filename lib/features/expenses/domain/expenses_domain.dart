enum ExpenseCategory {
  market,
  utilities,
  meal,
  maintenance,
  transport,
  other,
}

class ExpenseTransaction {
  const ExpenseTransaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.paidBy,
    required this.date,
    required this.category,
    required this.splitAmong,
  });

  final String id;
  final String title;
  final double amount;
  final String paidBy;
  final DateTime date;
  final ExpenseCategory category;
  final List<String> splitAmong;
}

class MemberContribution {
  const MemberContribution({
    required this.memberName,
    required this.paid,
    required this.due,
  });

  final String memberName;
  final double paid;
  final double due;
}

class MonthlyExpenseSummary {
  const MonthlyExpenseSummary({
    required this.monthLabel,
    required this.totalSpent,
    required this.totalCollected,
    required this.pendingDue,
  });

  final String monthLabel;
  final double totalSpent;
  final double totalCollected;
  final double pendingDue;
}

class ExpenseDashboardData {
  const ExpenseDashboardData({
    required this.summary,
    required this.transactions,
    required this.contributions,
    required this.categoryBreakdown,
    required this.adminControlsEnabled,
  });

  final MonthlyExpenseSummary summary;
  final List<ExpenseTransaction> transactions;
  final List<MemberContribution> contributions;
  final Map<ExpenseCategory, double> categoryBreakdown;
  final bool adminControlsEnabled;
}

abstract class ExpensesRepository {
  Future<ExpenseDashboardData> fetchDashboard();

  Future<void> createExpense({
    required String title,
    required double amount,
    required String paidBy,
    required ExpenseCategory category,
    required List<String> splitAmong,
  });
}
