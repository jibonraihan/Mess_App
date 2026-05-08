import 'package:flutter/material.dart';
import '../../domain/expenses_domain.dart';

class ExpensesChartPlaceholder extends StatelessWidget {
  const ExpensesChartPlaceholder({
    required this.categoryBreakdown,
    super.key,
  });

  final Map<ExpenseCategory, double> categoryBreakdown;

  @override
  Widget build(BuildContext context) {
    final total = categoryBreakdown.values.fold<double>(0, (a, b) => a + b);
    final entries = categoryBreakdown.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      children: [
        for (final entry in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _Bar(
              label: _label(entry.key),
              amount: entry.value,
              ratio: total == 0 ? 0 : entry.value / total,
            ),
          ),
      ],
    );
  }

  String _label(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.market:
        return 'Market';
      case ExpenseCategory.utilities:
        return 'Utilities';
      case ExpenseCategory.meal:
        return 'Meal';
      case ExpenseCategory.maintenance:
        return 'Maintenance';
      case ExpenseCategory.transport:
        return 'Transport';
      case ExpenseCategory.other:
        return 'Other';
    }
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.label,
    required this.amount,
    required this.ratio,
  });

  final String label;
  final double amount;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(label)),
            Text('৳${amount.toStringAsFixed(0)}'),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            minHeight: 10,
            value: ratio,
          ),
        ),
      ],
    );
  }
}
