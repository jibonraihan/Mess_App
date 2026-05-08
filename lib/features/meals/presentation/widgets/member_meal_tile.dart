import 'package:flutter/material.dart';
import '../../domain/meals_domain.dart';

class MemberMealTile extends StatelessWidget {
  const MemberMealTile({
    required this.item,
    super.key,
  });

  final MemberMealHistory item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(child: Text(item.memberName.substring(0, 1))),
      title: Text(item.memberName),
      subtitle: Text(
        'B:${item.breakfastCount} L:${item.lunchCount} D:${item.dinnerCount}',
      ),
      trailing: Text(
        '${item.monthlyTotal} meals',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
