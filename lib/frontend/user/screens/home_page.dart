// // ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:iconly/iconly.dart';
import 'package:rafay_portfolio/frontend/user/pages/aboutme/about_me.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/displayblogs/displayblogs.dart';
import 'package:rafay_portfolio/frontend/user/pages/contact_me/contact_me.dart';
import 'package:rafay_portfolio/frontend/user/pages/project_gallery/project_gallery.dart';
import 'package:rafay_portfolio/frontend/user/pages/experiences/resume.dart';
import 'package:rafay_portfolio/frontend/user/pages/landing/landing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _pageController = PageController();

  final List<Widget> _pages = [
    const LandingPage(),
    const AboutMe(),
    const Resume(),
    const ProjectGridView(),
    const DisplayBlog(),
    const ContactMe()
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.background,
    ));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Widget _buildBody() {
  //   return Column(
  //     children: <Widget>[
  //       Expanded(
  //         child: _pages[_currentIndex],
  //       ),
  //     ],
  //   );
  // }

  Widget _buildBody() {
    return PageView(
      controller: _pageController,
      onPageChanged: _handleIndexChanged,
      children: _pages,
    );
  }

  Widget _buildBottomNavigationBar() {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CrystalNavigationBar(
        currentIndex: _currentIndex,
        onTap: _handleIndexChanged,
        indicatorColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.black.withOpacity(0.1),
        marginR: isMobile
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
            : const EdgeInsets.symmetric(horizontal: 500, vertical: 20),
        items: _buildNavigationBarItems(),
      ),
    );
  }

  List<CrystalNavigationBarItem> _buildNavigationBarItems() {
    return [
      CrystalNavigationBarItem(
        icon: FontAwesomeIcons.house,
        unselectedColor: Colors.blue.shade200,
      ),
      CrystalNavigationBarItem(
        icon: FontAwesomeIcons.user,
        unselectedColor: Colors.redAccent,
      ),
      CrystalNavigationBarItem(
        icon: FontAwesomeIcons.briefcase,
        unselectedColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      CrystalNavigationBarItem(
        icon: FontAwesomeIcons.codePullRequest,
        unselectedColor: Colors.green.shade400,
      ),
      CrystalNavigationBarItem(
        icon: FontAwesomeIcons.blog,
        unselectedColor: Colors.brown,
      ),
      CrystalNavigationBarItem(
        icon: FontAwesomeIcons.message,
        unselectedColor: Colors.cyan.shade400,
      ),
    ];
  }

  //orginal code
  // void _handleIndexChanged(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

  void _handleIndexChanged(int index) {
    _pageController.jumpToPage(index);

    setState(() {
      _currentIndex = index;
    });
  }
}
