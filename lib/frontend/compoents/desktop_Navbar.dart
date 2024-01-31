// // desktop_navbar.dart
import 'package:flutter/material.dart';

import 'package:rafay_portfolio/frontend/compoents/NavbarItem.dart';

class DesktopNavBar extends StatefulWidget {
  const DesktopNavBar({super.key});

  @override
  State<DesktopNavBar> createState() => _DesktopNavBarState();
}

class _DesktopNavBarState extends State<DesktopNavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
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
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.5),
            child: const Row(
              children: [
                NavBarItem(
                  'Home',
                  icons: Icons.home_rounded,
                  routeName: '/home',
                ),
                NavBarItem(
                  'About Me',
                  icons: Icons.person_rounded,
                  routeName: '/aboutme',
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
