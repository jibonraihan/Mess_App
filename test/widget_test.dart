// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_app/app/app.dart';

void main() {
  testWidgets('loads app shell and primary section', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MessApp()));
    await tester.pumpAndSettle();

    expect(find.text('Mess Manager'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
  });
}
