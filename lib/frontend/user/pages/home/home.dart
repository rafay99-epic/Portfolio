import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/user/pages/home/widgets/mobile/NavigationBarItems.dart';
import 'package:rafay_portfolio/frontend/user/screens/menuSwitcher.dart';
import 'package:rafay_portfolio/frontend/user/pages/aboutme/about_me.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/displayblogs/displayblogs.dart';
import 'package:rafay_portfolio/frontend/user/pages/experiences/resume.dart';
import 'package:rafay_portfolio/frontend/user/pages/landing/landing_page.dart';
import 'package:rafay_portfolio/frontend/user/pages/project_gallery/project_gallery.dart';
import 'package:rafay_portfolio/frontend/user/pages/contact_me/contact_me.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const MenuSwitcher(pages: [
        LandingPage(),
        AboutMe(),
        ProjectGridView(),
        Resume(),
        DisplayBlog(),
      ]);
    } else {
      final List<Widget> pages = [
        const LandingPage(),
        const AboutMe(),
        const Resume(),
        const ProjectGridView(),
        const DisplayBlog(),
        const ContactMe(),
      ];

      void handleIndexChanged(int index) {
        _pageController.jumpToPage(index);

        setState(() {
          _currentIndex = index;
        });
      }

      Widget buildBody() {
        return PageView(
          controller: _pageController,
          onPageChanged: handleIndexChanged,
          children: pages,
        );
      }

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: buildBody(),
        bottomNavigationBar: buildBottomNavigationBar(
            context, _currentIndex, handleIndexChanged),
      );
    }
  }
}
