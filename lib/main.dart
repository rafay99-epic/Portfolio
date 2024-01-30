import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/screens/NotFound_page.dart';
import 'package:rafay_portfolio/frontend/screens/blog.dart';
import 'frontend/screens/Resume_page.dart';
import 'frontend/screens/contentMe_page.dart';
import 'frontend/screens/splash_page.dart';
import 'frontend/theme/light.dart';
import 'frontend/screens/home_page.dart';
import 'frontend/screens/service_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: const SplashScreen(),
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomePage(),
        '/services': (context) => const ServicesPage(),
        '/resume': (context) => const ResumePage(),
        '/contact': (context) => const ContactMePage(),
        '/blog': (context) => const BlogPage(),
        '/404': (context) => const NotFoundPage(),
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: lightMode,
//       initialRoute: '/',
//       onGenerateRoute: (RouteSettings settings) {
//         switch (settings.name) {
//           case '/':
//             return MaterialPageRoute(
//                 builder: (context) => const SplashScreen());
//           case '/home':
//             return MaterialPageRoute(builder: (context) => const HomePage());
//           case '/services':
//             return MaterialPageRoute(
//                 builder: (context) => const ServicesPage());
//           case '/resume':
//             return MaterialPageRoute(builder: (context) => const ResumePage());
//           case '/contact':
//             return MaterialPageRoute(
//                 builder: (context) => const ContactMePage());
//           case '/blog':
//             return MaterialPageRoute(builder: (context) => const BlogPage());
//           default:
//             return MaterialPageRoute(
//                 builder: (context) =>
//                     const NotFoundPage()); // Return a page for not found routes
//         }
//       },
//     );
//   }
// }
