import "package:flutter/material.dart";
// Admin Pages
import 'package:rafay_portfolio/frontend/admin/pages/auth/loginPage.dart';
import 'package:rafay_portfolio/frontend/user/pages/aboutme/about_me.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/displayblogs.dart';
import 'package:rafay_portfolio/frontend/user/pages/error/page404.dart';
import 'package:rafay_portfolio/frontend/user/pages/experiences/project_gallery.dart';
import 'package:rafay_portfolio/frontend/user/pages/experiences/resume.dart';
import 'package:rafay_portfolio/frontend/user/screens/contentMe_page.dart';

// user Page

import 'package:rafay_portfolio/frontend/user/screens/home_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/home': (context) => const HomePage(),
  '/projects': (context) => const ProjectGallery(),
  '/resume': (context) => const Resume(),
  '/contact': (context) => const ContactMePage(),
  '/blog': (context) => const DisplayBlog(),
  '/aboutme': (context) => const AboutMe(),
  '/404': (context) => const Page404(),
  '/admin': (context) => const LoginAdmin(),
};
