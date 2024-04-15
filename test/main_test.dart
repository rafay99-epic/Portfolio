import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/backend/auth/auth_gate.dart';
import 'package:rafay_portfolio/frontend/user/screens/splash_page.dart';
import 'package:rafay_portfolio/main.dart';

void main() {
  testWidgets('MyApp builds MaterialApp and checks routes',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that MyApp creates MaterialApp.
    expect(find.byType(MaterialApp), findsOneWidget);

    // Test initial route
    expect(find.byType(SplashScreen), findsOneWidget);

    // Test navigation to the '/admin' route
    await tester.tap(find.text('/admin'));
    await tester.pumpAndSettle();

    // Verify that AuthGate widget is shown
    expect(find.byType(AuthGate), findsOneWidget);
  });
}
