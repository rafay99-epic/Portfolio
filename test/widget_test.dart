import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/main.dart';

void main() {
  testWidgets('MyApp builds MaterialApp', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our widget MyApp builds MaterialApp.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
