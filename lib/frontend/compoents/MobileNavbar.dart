// mobile_navbar.dart
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/compoents/NavbarItem.dart';

class MobileNavBar extends StatelessWidget {
  const MobileNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(child: Text('Menu')),
          NavBarItem(
            'Home',
            icons: Icons.home_rounded,
            routeName: '/home',
          ),
          NavBarItem(
            'Services',
            icons: Icons.settings_rounded,
            routeName: '/services',
          ),
          NavBarItem(
            'Resume',
            icons: Icons.description_rounded,
            routeName: '/resume',
          ),
          NavBarItem(
            'Contact Me',
            icons: Icons.mail_rounded,
            routeName: '/contact',
          ),
          NavBarItem(
            'Blog',
            icons: Icons.rss_feed_rounded,
            routeName: '/blog',
          ),
        ],
      ),
    );
  }
}
