import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rafay_portfolio/admin/backend/auth/auth_gate.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:rafay_portfolio/admin/frontend/pages/loginPage.dart';
import 'package:rafay_portfolio/constants/routes/routes.dart';
import 'package:rafay_portfolio/user/frontend/screens/NotFound_page.dart';
import 'user/frontend/screens/splash_page.dart';
import 'constants/theme/light.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      onGenerateInitialRoutes: (String initialRoute) {
        return [
          MaterialPageRoute(
            builder: (context) {
              // return initialRoute == '/'
              //     ? const SplashScreen()
              //     : const NotFoundPage();
              return initialRoute == '/'
                  ? const SplashScreen()
                  : initialRoute == '/admin'
                      ? const AuthGate()
                      : const NotFoundPage();
            },
          ),
        ];
      },
      routes: appRoutes,
      // routes: {
      //   '/home': (context) => const HomePage(),
      //   '/projects': (context) => const ProjectGalleryPage(),
      //   '/resume': (context) => const ResumePage(),
      //   '/contact': (context) => const ContactMePage(),
      //   '/blog': (context) => const BlogPage(),
      //   '/aboutme': (context) => const AboutMePage(),
      //   '/404': (context) => const NotFoundPage(),
      // },
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:rafay_portfolio/admin/frontend/pages/loginPage.dart';
// import 'package:url_strategy/url_strategy.dart';

// import 'package:rafay_portfolio/constants/routes/routes.dart';
// import 'package:rafay_portfolio/user/frontend/screens/NotFound_page.dart';
// import 'user/frontend/screens/splash_page.dart';
// import 'constants/theme/light.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyBStUH7MVMjr9btBvT4eOBanEIL84FhcvQ",
//       appId: "1:182119041017:web:f1f49656712460a41f9f28",
//       messagingSenderId: "182119041017",
//       projectId: "portfolio-f4698",
//     ),
//   );
//   setPathUrlStrategy();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: lightMode,
//       home: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator(); // Show loading indicator while waiting
//           } else {
//             if (snapshot.hasData) {
//               return const SplashScreen(); // User is logged in, show the home screen
//             } else {
//               return const LoginAdmin(); // User is not logged in, show the login screen
//             }
//           }
//         },
//       ),
//       onGenerateInitialRoutes: (String initialRoute) {
//         return [
//           MaterialPageRoute(
//             builder: (context) {
//               return initialRoute == '/'
//                   ? const SplashScreen()
//                   : initialRoute == '/admin'
//                       ? const LoginAdmin()
//                       : const NotFoundPage();
//             },
//           ),
//         ];
//       },
//       routes: appRoutes,
//     );
//   }
// }
