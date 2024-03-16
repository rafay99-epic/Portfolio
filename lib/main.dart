import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rafay_portfolio/admin/backend/auth/auth_gate.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:rafay_portfolio/constants/routes/routes.dart';
import 'package:rafay_portfolio/user/frontend/screens/NotFound_page.dart';
import 'user/frontend/screens/splash_page.dart';
import 'constants/theme/light.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBStUH7MVMjr9btBvT4eOBanEIL84FhcvQ",
      appId: "1:182119041017:web:f1f49656712460a41f9f28",
      messagingSenderId: "182119041017",
      projectId: "portfolio-f4698",
      storageBucket: "portfolio-f4698.appspot.com",
      authDomain: "portfolio-f4698.firebaseapp.com",
      measurementId: "G-W0TW5XLX4T",
    ),
  );
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
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const NotFoundPage(),
      ),
    );
  }
}






//  ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗    ██████╗ ██╗      █████╗ ████████╗███████╗ ██████╗ ██████╗ ███╗   ███╗
// ██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝    ██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔════╝██╔═══██╗██╔══██╗████╗ ████║
// ██║     ███████║█████╗  ██║     █████╔╝     ██████╔╝██║     ███████║   ██║   █████╗  ██║   ██║██████╔╝██╔████╔██║
// ██║     ██╔══██║██╔══╝  ██║     ██╔═██╗     ██╔═══╝ ██║     ██╔══██║   ██║   ██╔══╝  ██║   ██║██╔══██╗██║╚██╔╝██║
// ╚██████╗██║  ██║███████╗╚██████╗██║  ██╗    ██║     ███████╗██║  ██║   ██║   ██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║
//  ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝    ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝
                                                                                                                 



// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:rafay_portfolio/admin/backend/auth/auth_gate.dart';
// import 'package:url_strategy/url_strategy.dart';

// import 'package:rafay_portfolio/constants/routes/routes.dart';
// import 'package:rafay_portfolio/user/frontend/screens/NotFound_page.dart';
// import 'user/frontend/screens/splash_page.dart';
// import 'constants/theme/light.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyBStUH7MVMjr9btBvT4eOBanEIL84FhcvQ",
//       appId: "1:182119041017:web:f1f49656712460a41f9f28",
//       messagingSenderId: "182119041017",
//       projectId: "portfolio-f4698",
//       storageBucket: "portfolio-f4698.appspot.com",
//       authDomain: "portfolio-f4698.firebaseapp.com",
//       measurementId: "G-W0TW5XLX4T",
//     ),
//   );
//   setPathUrlStrategy();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
//   static FirebaseAnalyticsObserver observer =
//       FirebaseAnalyticsObserver(analytics: analytics);

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, WidgetBuilder> routes = {
//       '/': (context) => const SplashScreen(),
//       ...appRoutes,
//     };
//     if (kIsWeb) {
//       routes.addAll({
//         '/admin': (context) => const AuthGate(),
//       });
//     }
//     return MaterialApp(
//       navigatorObservers: <NavigatorObserver>[observer],
//       debugShowCheckedModeBanner: false,
//       theme: lightMode,
//       initialRoute: '/',
//       routes: routes,
//       onUnknownRoute: (settings) => MaterialPageRoute(
//         builder: (context) => const NotFoundPage(),
//       ),
//     );
//   }
// }
