import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/expenses_controller.dart';
import '../../domain/expenses_domain.dart';
import '../widgets/expense_dashboard_card.dart';
import '../widgets/expenses_chart_placeholder.dart';
import '../widgets/member_contribution_tile.dart';
import '../widgets/statistic_pill.dart';
import '../widgets/transaction_card.dart';
import '../../../../core/responsive/responsive_breakpoints.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(expensesControllerProvider);
    final controller = ref.read(expensesControllerProvider.notifier);
    final data = state.data;
    final isDesktop = ResponsiveBreakpoints.isDesktop(context);

    if (state.isLoading && data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data == null) {
      return Center(
        child: FilledButton.tonal(
          onPressed: controller.load,
          child: const Text('Retry expenses'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Expense Management', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 4),
                    Text(
                      'Fintech-style overview for expenses, balances, split and dues.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: () => _showAddExpenseSheet(context, ref),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add expense'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              StatisticPill(
                label: 'Monthly spent',
                value: '৳${data.summary.totalSpent.toStringAsFixed(0)}',
                icon: Icons.payments_rounded,
              ),
              StatisticPill(
                label: 'Collected',
                value: '৳${data.summary.totalCollected.toStringAsFixed(0)}',
                icon: Icons.savings_rounded,
              ),
              StatisticPill(
                label: 'Pending due',
                value: '৳${data.summary.pendingDue.toStringAsFixed(0)}',
                icon: Icons.pending_actions_rounded,
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ExpenseDashboardCard(
                    title: 'Monthly summary - ${data.summary.monthLabel}',
                    child: ExpensesChartPlaceholder(
                      categoryBreakdown: data.categoryBreakdown,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ExpenseDashboardCard(
                    title: 'Split bill and dues',
                    child: _SplitBillOverview(data: data),
                  ),
                ),
              ],
            )
          else ...[
            ExpenseDashboardCard(
              title: 'Monthly summary - ${data.summary.monthLabel}',
              child: ExpensesChartPlaceholder(
                categoryBreakdown: data.categoryBreakdown,
              ),
            ),
            const SizedBox(height: 12),
            ExpenseDashboardCard(
              title: 'Split bill and dues',
              child: _SplitBillOverview(data: data),
            ),
          ],
          const SizedBox(height: 12),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ExpenseDashboardCard(
                    title: 'Member contributions',
                    child: Column(
                      children: data.contributions
                          .map((item) => MemberContributionTile(item: item))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ExpenseDashboardCard(
                    title: 'Admin controls',
                    child: _AdminControls(enabled: data.adminControlsEnabled),
                  ),
                ),
              ],
            )
          else ...[
            ExpenseDashboardCard(
              title: 'Member contributions',
              child: Column(
                children: data.contributions
                    .map((item) => MemberContributionTile(item: item))
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            ExpenseDashboardCard(
              title: 'Admin controls',
              child: _AdminControls(enabled: data.adminControlsEnabled),
            ),
          ],
          const SizedBox(height: 12),
          ExpenseDashboardCard(
            title: 'Expense history',
            action: state.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : IconButton(
                    onPressed: controller.load,
                    icon: const Icon(Icons.refresh_rounded),
                  ),
            child: Column(
              children: data.transactions
                  .map(
                    (tx) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AnimatedSlide(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        offset: Offset.zero,
                        child: TransactionCard(transaction: tx),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplitBillOverview extends StatelessWidget {
  const _SplitBillOverview({required this.data});

  final ExpenseDashboardData data;

  @override
  Widget build(BuildContext context) {
    final membersCount = data.contributions.length;
    final perHead = membersCount == 0 ? 0 : data.summary.totalSpent / membersCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Estimated per head share: ৳${perHead.toStringAsFixed(0)}'),
        const SizedBox(height: 10),
        Text('Active members: $membersCount'),
        const SizedBox(height: 10),
        Text('Pending dues total: ৳${data.summary.pendingDue.toStringAsFixed(0)}'),
      ],
    );
  }
}

class _AdminControls extends StatelessWidget {
  const _AdminControls({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          value: enabled,
          onChanged: (_) {},
          contentPadding: EdgeInsets.zero,
          title: const Text('Allow expense edit approvals'),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            Chip(label: Text('Export report')),
            Chip(label: Text('Lock month')),
            Chip(label: Text('Settle dues')),
          ],
        ),
      ],
    );
  }
}

Future<void> _showAddExpenseSheet(BuildContext context, WidgetRef ref) async {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final paidByController = TextEditingController(text: 'Rahim');
  ExpenseCategory selectedCategory = ExpenseCategory.market;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              top: 8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Expense title'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Amount'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: paidByController,
                  decoration: const InputDecoration(labelText: 'Paid by'),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<ExpenseCategory>(
                  value: selectedCategory,
                  items: ExpenseCategory.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedCategory = value);
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      final amount = double.tryParse(amountController.text.trim());
                      if (titleController.text.trim().isEmpty || amount == null) return;
                      await ref.read(expensesControllerProvider.notifier).addExpense(
                            title: titleController.text.trim(),
                            amount: amount,
                            paidBy: paidByController.text.trim().isEmpty
                                ? 'Unknown'
                                : paidByController.text.trim(),
                            category: selectedCategory,
                            splitAmong: const ['Rahim', 'Karim', 'Sakib', 'Jamal', 'Tanjim'],
                          );
                      if (context.mounted) Navigator.pop(context);
                    },
                    child: const Text('Save expense'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
