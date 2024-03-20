import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rafay_portfolio/admin/backend/auth/auth_gate.dart';
import 'package:rafay_portfolio/firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:rafay_portfolio/constants/routes/routes.dart';
import 'package:rafay_portfolio/user/frontend/screens/NotFound_page.dart';
import 'user/frontend/screens/splash_page.dart';
import 'constants/theme/light.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase init with platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //firebase Error Catching and Crash Reporting
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  ui.PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  //setup URLs
  setPathUrlStrategy();

  // Running the application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Firebase Analytics
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  //Main Widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/admin': (context) => const AuthGate(),
        ...appRoutes,
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const NotFoundPage(),
      ),
    );
  }
}
