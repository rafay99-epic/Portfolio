import 'package:flutter/material.dart';
import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:google_fonts/google_fonts.dart';

class MyNavBar extends StatelessWidget implements PreferredSizeWidget {
  const MyNavBar({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AdaptiveNavBar(
        //disabling the back button
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        screenWidth: sw,
        toolbarHeight: 80.0,
        title: const Text(
          "Abdul Rafay",
        ),
        titleTextStyle: GoogleFonts.roboto(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
        toolbarTextStyle: GoogleFonts.roboto(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),

        navBarItems: [
          NavBarItem(
            text: "Home",
            highlightColor: Theme.of(context).colorScheme.primary,
            hoverColor: Theme.of(context).colorScheme.inversePrimary,
            focusColor: Theme.of(context).colorScheme.primary,
            onTap: () {
              Navigator.pushNamed(context, "/home");
            },
          ),
          NavBarItem(
            text: "About Me",
            highlightColor: Theme.of(context).colorScheme.primary,
            focusColor: Theme.of(context).colorScheme.primary,
            hoverColor: Theme.of(context).colorScheme.inversePrimary,
            onTap: () {
              Navigator.pushNamed(context, "/aboutme");
            },
          ),
          NavBarItem(
            text: "Services",
            highlightColor: Theme.of(context).colorScheme.primary,
            focusColor: Theme.of(context).colorScheme.primary,
            hoverColor: Theme.of(context).colorScheme.inversePrimary,
            onTap: () {
              Navigator.pushNamed(context, "/services");
            },
          ),
          NavBarItem(
            text: "Resume",
            highlightColor: Theme.of(context).colorScheme.primary,
            focusColor: Theme.of(context).colorScheme.primary,
            hoverColor: Theme.of(context).colorScheme.inversePrimary,
            onTap: () {
              Navigator.pushNamed(context, "/resume");
            },
          ),
          NavBarItem(
            text: "Contact Me",
            focusColor: Theme.of(context).colorScheme.primary,
            hoverColor: Theme.of(context).colorScheme.inversePrimary,
            onTap: () {
              Navigator.pushNamed(context, "/contact");
            },
          ),
          NavBarItem(
            text: "Blog",
            highlightColor: Theme.of(context).colorScheme.primary,
            focusColor: Theme.of(context).colorScheme.primary,
            hoverColor: Theme.of(context).colorScheme.inversePrimary,
            onTap: () {
              Navigator.pushNamed(context, "/blog");
            },
          ),
        ],
      ),
    );
  }
}
