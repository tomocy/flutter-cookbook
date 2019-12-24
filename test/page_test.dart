import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cookbook/main.dart';

void main() {
  testWidgets('Page add a todo to and remote from its list', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Page(),
    ));

    final todoFinder = find.text('todo');
    await tester.enterText(find.byType(TextFormField), 'todo');
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(todoFinder, findsOneWidget);

    await tester.drag(find.byType(Dismissible), const Offset(500.0, 0.0));
    await tester.pumpAndSettle();

    expect(todoFinder, findsNothing);
  });
}
