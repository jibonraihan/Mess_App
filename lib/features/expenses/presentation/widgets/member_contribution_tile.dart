import 'package:flutter/material.dart';
import '../../domain/expenses_domain.dart';

class MemberContributionTile extends StatelessWidget {
  const MemberContributionTile({
    required this.item,
    super.key,
  });

  final MemberContribution item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Text(item.memberName.substring(0, 1)),
      ),
      title: Text(item.memberName),
      subtitle: Text('Paid ৳${item.paid.toStringAsFixed(0)}'),
      trailing: Text(
        'Due ৳${item.due.toStringAsFixed(0)}',
        style: TextStyle(
          color: item.due > 0
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
