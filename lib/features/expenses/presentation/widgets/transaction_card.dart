import 'package:flutter/material.dart';
import '../../domain/expenses_domain.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({required this.transaction, super.key});

  final ExpenseTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(_iconForCategory(transaction.category)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.title, style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 2),
                  Text('Paid by ${transaction.paidBy}'),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '৳${transaction.amount.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForCategory(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.market:
        return Icons.shopping_basket_rounded;
      case ExpenseCategory.utilities:
        return Icons.bolt_rounded;
      case ExpenseCategory.meal:
        return Icons.restaurant_rounded;
      case ExpenseCategory.maintenance:
        return Icons.build_rounded;
      case ExpenseCategory.transport:
        return Icons.directions_bus_rounded;
      case ExpenseCategory.other:
        return Icons.receipt_long_rounded;
    }
  }
}
