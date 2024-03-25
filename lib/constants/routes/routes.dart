import "package:flutter/material.dart";
// Admin Pages
import 'package:rafay_portfolio/admin/frontend/pages/auth/loginPage.dart';
import 'package:rafay_portfolio/user/frontend/pages/aboutme/about_me.dart';
import 'package:rafay_portfolio/user/frontend/pages/blogs/displayblogs.dart';
import 'package:rafay_portfolio/user/frontend/pages/error/page404.dart';
import 'package:rafay_portfolio/user/frontend/pages/experiences/project_gallery.dart';
import 'package:rafay_portfolio/user/frontend/pages/experiences/resume.dart';
import 'package:rafay_portfolio/user/frontend/screens/contentMe_page.dart';

// user Page

import 'package:rafay_portfolio/user/frontend/screens/home_page.dart';

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
