import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rafay_portfolio/backend/auth/auth_gate.dart';
import 'package:rafay_portfolio/firebase_options.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/readblogs/read_blog.dart';
import 'package:rafay_portfolio/frontend/user/pages/error/page404.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:rafay_portfolio/constants/routes/routes.dart';

import 'frontend/user/screens/splash_page.dart';
import 'constants/theme/light.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  ui.PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
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
      onGenerateRoute: (settings) {
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length >= 2 && uri.pathSegments.first == 'blog') {
          var url = uri.pathSegments.sublist(1).join('/');
          return MaterialPageRoute(
            builder: (context) => ReadMeBlogs(
              url: url,
            ),
          );
        }
        return MaterialPageRoute(builder: (context) => const Page404());
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Page404(),
      ),
    );
  }
}
