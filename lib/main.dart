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
      onUnknownRoute: (settings) {
        // Return the 'NotFoundPage' for all unknown routes.
        return MaterialPageRoute(builder: (context) => const NotFoundPage());
      },
    );
  }
}
