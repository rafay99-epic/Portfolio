import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';

import 'package:rafay_portfolio/frontend/widgets/landing_page.dart';
import 'package:rafay_portfolio/frontend/screens/Resume_page.dart';
import 'package:rafay_portfolio/frontend/screens/aboutme_page.dart';
import 'package:rafay_portfolio/frontend/screens/blog_page.dart';
import 'package:rafay_portfolio/frontend/screens/contentMe_page.dart';
import 'package:rafay_portfolio/frontend/screens/service_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const LandingPage(),
    const ServicesPage(),
    const ResumePage(),
    const ContactMePage(),
    const BlogPage(),
    const AboutMePage(),
  ];

  @override
  Widget build(BuildContext context) {
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
          marginR: const EdgeInsets.symmetric(horizontal: 500, vertical: 20),
          items: [
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedColor: Colors.blue.shade200,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.activity,
              unselectedColor: Colors.red.shade400,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.document,
              unselectedColor: Colors.black,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.message,
              unselectedColor: Colors.cyan.shade400,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.bag_2,
              unselectedColor: Colors.brown,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.user_2,
              unselectedColor: Colors.redAccent,
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
