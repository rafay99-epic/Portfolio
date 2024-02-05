import 'package:flutter/material.dart';
import 'package:rafay_portfolio/admin/frontend/pages/loginPage.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:rafay_portfolio/constants/routes/routes.dart';
import 'package:rafay_portfolio/user/frontend/screens/NotFound_page.dart';
import 'user/frontend/screens/splash_page.dart';
import 'constants/theme/light.dart';

void main() {
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
                      ? const LoginAdmin()
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
