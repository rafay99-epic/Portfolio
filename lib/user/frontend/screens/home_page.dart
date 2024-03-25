import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:rafay_portfolio/user/frontend/pages/aboutme/about_me.dart';
import 'package:rafay_portfolio/user/frontend/pages/blogs/displayblogs.dart';
import 'package:rafay_portfolio/user/frontend/pages/contact_me/contact_me.dart';
import 'package:rafay_portfolio/user/frontend/pages/experiences/project_gallery.dart';
import 'package:rafay_portfolio/user/frontend/pages/experiences/resume.dart';

import 'package:rafay_portfolio/user/frontend/pages/landing/landing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const LandingPage(),
    const Resume(),
    const ProjectGallery(),
    const AboutMe(),
    const DisplayBlog(),
    const ContactMe()
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.background,
    ));
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: <Widget>[
          Expanded(
            child: _pages[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CrystalNavigationBar(
          currentIndex: _currentIndex,
          onTap: _handleIndexChanged,
          indicatorColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.1),
          // marginR: const EdgeInsets.symmetric(horizontal: 500, vertical: 20),
          marginR: isMobile
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
              : const EdgeInsets.symmetric(horizontal: 500, vertical: 20),
          items: [
            //!home Page OR landing
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedColor: Colors.blue.shade200,
            ),
            // !ResumePage
            CrystalNavigationBarItem(
              icon: IconlyBold.document,
              unselectedColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            // ! Project Gallery Page
            CrystalNavigationBarItem(
              icon: FontAwesomeIcons.codePullRequest,
              unselectedColor: Colors.green.shade400,
            ),
            // !About ME Page
            CrystalNavigationBarItem(
              icon: IconlyBold.user_2,
              unselectedColor: Colors.redAccent,
            ),
            // ! Blog Page
            CrystalNavigationBarItem(
              icon: FontAwesomeIcons.rss,
              unselectedColor: Colors.brown,
            ),
            // ! Contact Me Page
            CrystalNavigationBarItem(
              icon: IconlyBold.message,
              unselectedColor: Colors.cyan.shade400,
            ),
          ],
        ),
      ),
    );
  }

  void _handleIndexChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
