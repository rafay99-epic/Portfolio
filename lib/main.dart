import 'package:flutter/material.dart';

import 'frontend/screens/Resume_page.dart';
import 'frontend/screens/contentMe_page.dart';
import 'frontend/screens/projectsGallary_page.dart';
import 'frontend/screens/splash_page.dart';
import 'frontend/theme/light.dart';
import 'frontend/screens/home_page.dart';
import 'frontend/screens/certification_page.dart';
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
      routes: {
        '/home': (context) => const HomePage(),
        '/services': (context) => const ServicesPage(),
        '/contactme': (context) => const ContactMePage(),
        '/certification': (context) => const CertificationPage(),
        '/projectgallery': (context) => const ProjectGalleryPage(),
        '/resume': (context) => const ResumePage(),
      },
    );
  }
}
