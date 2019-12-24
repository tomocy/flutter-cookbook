import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cookbook/main.dart';

void main() {
  testWidgets('Page has a title and message', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Page(
        title: 't',
        message: 'm',
      ),
    ));

    final titleFinder = find.text('t');
    final messageFinder = find.text('m');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
