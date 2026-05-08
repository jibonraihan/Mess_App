import '../domain/expenses_domain.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  final List<ExpenseTransaction> _transactions = [
    ExpenseTransaction(
      id: 'tx-1',
      title: 'Weekly vegetable market',
      amount: 2850,
      paidBy: 'Rahim',
      date: DateTime(2026, 5, 6),
      category: ExpenseCategory.market,
      splitAmong: ['Rahim', 'Karim', 'Sakib', 'Jamal', 'Tanjim'],
    ),
    ExpenseTransaction(
      id: 'tx-2',
      title: 'Gas bill',
      amount: 1900,
      paidBy: 'Karim',
      date: DateTime(2026, 5, 4),
      category: ExpenseCategory.utilities,
      splitAmong: ['Rahim', 'Karim', 'Sakib', 'Jamal', 'Tanjim'],
    ),
    ExpenseTransaction(
      id: 'tx-3',
      title: 'Rice stock refill',
      amount: 3200,
      paidBy: 'Sakib',
      date: DateTime(2026, 5, 2),
      category: ExpenseCategory.meal,
      splitAmong: ['Rahim', 'Karim', 'Sakib', 'Jamal', 'Tanjim'],
    ),
  ];

  @override
  Future<ExpenseDashboardData> fetchDashboard() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    const totalCollected = 15800.0;
    final totalSpent = _transactions.fold<double>(
      0,
      (sum, item) => sum + item.amount,
    );

    return ExpenseDashboardData(
      summary: MonthlyExpenseSummary(
        monthLabel: 'May 2026',
        totalSpent: totalSpent,
        totalCollected: totalCollected,
        pendingDue: totalSpent - totalCollected > 0 ? totalSpent - totalCollected : 0,
      ),
      transactions: List.unmodifiable(_transactions),
      contributions: const [
        MemberContribution(memberName: 'Rahim', paid: 4500, due: 600),
        MemberContribution(memberName: 'Karim', paid: 3900, due: 1050),
        MemberContribution(memberName: 'Sakib', paid: 3100, due: 1240),
        MemberContribution(memberName: 'Jamal', paid: 2200, due: 1770),
        MemberContribution(memberName: 'Tanjim', paid: 2100, due: 1890),
      ],
      categoryBreakdown: {
        ExpenseCategory.market: 4200,
        ExpenseCategory.utilities: 2400,
        ExpenseCategory.meal: 5300,
        ExpenseCategory.maintenance: 900,
        ExpenseCategory.transport: 700,
        ExpenseCategory.other: 450,
      },
      adminControlsEnabled: true,
    );
  }

  @override
  Future<void> createExpense({
    required String title,
    required double amount,
    required String paidBy,
    required ExpenseCategory category,
    required List<String> splitAmong,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _transactions.insert(
      0,
      ExpenseTransaction(
        id: 'tx-${DateTime.now().millisecondsSinceEpoch}',
        title: title,
        amount: amount,
        paidBy: paidBy,
        date: DateTime.now(),
        category: category,
        splitAmong: splitAmong,
      ),
    );
  }
}
