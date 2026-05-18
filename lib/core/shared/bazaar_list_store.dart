import 'package:flutter/material.dart';

final ValueNotifier<String> todaysBazaarList = ValueNotifier<String>('');
final ValueNotifier<DateTime?> bazaarListUpdatedAt = ValueNotifier<DateTime?>(
  null,
);
