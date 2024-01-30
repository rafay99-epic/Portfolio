// // desktop_navbar.dart
import 'package:flutter/material.dart';

import 'package:rafay_portfolio/frontend/compoents/NavbarItem.dart';

class DesktopNavBar extends StatelessWidget {
  const DesktopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/image/author.jpg'),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            'Abdul Rafay',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20.0,
              // fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 1050.0),
            child: Row(
              children: [
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
          ),
        ],
      ),
    );
  }
}
