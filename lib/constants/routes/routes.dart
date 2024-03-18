import "package:flutter/material.dart";
// Admin Pages
import 'package:rafay_portfolio/admin/frontend/pages/auth/loginPage.dart';

// user Page
import 'package:rafay_portfolio/user/frontend/screens/NotFound_page.dart';
import 'package:rafay_portfolio/user/frontend/screens/ProjectGalley_Page.dart';
import 'package:rafay_portfolio/user/frontend/screens/Resume_page.dart';
import 'package:rafay_portfolio/user/frontend/screens/aboutme_page.dart';
import 'package:rafay_portfolio/user/frontend/screens/blog_page.dart';
import 'package:rafay_portfolio/user/frontend/screens/contentMe_page.dart';
import 'package:rafay_portfolio/user/frontend/screens/home_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/home': (context) => const HomePage(),
  '/projects': (context) => const ProjectGalleryPage(),
  '/resume': (context) => const ResumePage(),
  '/contact': (context) => const ContactMePage(),
  '/blog': (context) => const BlogPage(),
  '/aboutme': (context) => const AboutMePage(),
  '/404': (context) => const NotFoundPage(),
  '/admin': (context) => const LoginAdmin(),
};
