import "package:flutter/material.dart";

import 'package:rafay_portfolio/frontend/admin/pages/auth/loginPage.dart';
import 'package:rafay_portfolio/frontend/user/pages/aboutme/about_me.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/displayblogs/displayblogs.dart';
import 'package:rafay_portfolio/frontend/user/pages/error/page404.dart';
import 'package:rafay_portfolio/frontend/user/pages/project_gallery/project_gallery.dart';
import 'package:rafay_portfolio/frontend/user/pages/experiences/resume.dart';
import 'package:rafay_portfolio/frontend/user/screens/contact_me_page.dart';
import 'package:rafay_portfolio/frontend/user/screens/home_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/home': (context) => const HomePage(),
  '/projects': (context) => const ProjectGridView(),
  '/resume': (context) => const Resume(),
  '/contact': (context) => const ContactMePage(),
  '/blog': (context) => const DisplayBlog(),
  '/aboutme': (context) => const AboutMe(),
  '/404': (context) => const Page404(),
  '/admin': (context) => const LoginAdmin(),
};
