import "package:flutter/material.dart";

import "package:rafay_portfolio/frontend/screens/NotFound_page.dart";
import "package:rafay_portfolio/frontend/screens/ProjectGalley_Page.dart";
import "package:rafay_portfolio/frontend/screens/Resume_page.dart";
import "package:rafay_portfolio/frontend/screens/aboutme_page.dart";
import "package:rafay_portfolio/frontend/screens/blog_page.dart";
import "package:rafay_portfolio/frontend/screens/contentMe_page.dart";
import "package:rafay_portfolio/frontend/screens/home_page.dart";

final Map<String, WidgetBuilder> appRoutes = {
  '/home': (context) => const HomePage(),
  '/projects': (context) => const ProjectGalleryPage(),
  '/resume': (context) => const ResumePage(),
  '/contact': (context) => const ContactMePage(),
  '/blog': (context) => const BlogPage(),
  '/aboutme': (context) => const AboutMePage(),
  '/404': (context) => const NotFoundPage(),
};
