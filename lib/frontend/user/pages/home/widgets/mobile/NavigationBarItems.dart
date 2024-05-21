import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildBottomNavigationBar(
  BuildContext context,
  int currentIndex,
  Function(int) handleIndexChanged,
) {
  bool isMobile = MediaQuery.of(context).size.width < 600;

  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: CrystalNavigationBar(
      currentIndex: currentIndex,
      onTap: handleIndexChanged,
      indicatorColor: Colors.white,
      unselectedItemColor: Colors.white70,
      backgroundColor: Colors.black.withOpacity(0.1),
      marginR: isMobile
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
          : const EdgeInsets.symmetric(horizontal: 500, vertical: 20),
      items: buildNavigationBarItems(context),
    ),
  );
}

List<CrystalNavigationBarItem> buildNavigationBarItems(BuildContext context) {
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
