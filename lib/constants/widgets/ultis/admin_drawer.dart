import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rafay_portfolio/frontend/admin/pages/article/articles.dart';
import 'package:rafay_portfolio/frontend/admin/pages/dashboardPage.dart';
import 'package:rafay_portfolio/frontend/admin/view/MessageDashboard.dart';

class MyDrawerAdmin extends StatefulWidget {
  const MyDrawerAdmin({super.key});

  @override
  State<MyDrawerAdmin> createState() => _MyDrawerAdminState();
}

class _MyDrawerAdminState extends State<MyDrawerAdmin>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _animation = Tween<double>(begin: -1, end: 0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void open() {
    _animationController.forward();
  }

  void close() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    const double width = 0;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value * width, 0),
          child: SizedBox(
            child: Drawer(
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Image.asset(
                        "assets/image/favicon.png",
                        width: 200,
                        height: 200,
                      ),
                      Text(
                        'Abdul Rafay',
                        style: GoogleFonts.playfairDisplay(
                          textStyle: TextStyle(
                            letterSpacing: .5,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: ListTile(
                          title: Text(
                            "D A S H B O A R D",
                            style: GoogleFonts.playfairDisplay(
                              color: Theme.of(context).colorScheme.primary,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: const Icon(Icons.home_rounded),
                          onTap: () => {
                            //opening the Home Page by closing the drawer
                            Navigator.pop(context),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DashboardPage(),
                              ),
                            ),
                          },
                        ),
                      ),
                      //Setting Page Item
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: ListTile(
                          title: Text(
                            "M E S S A G E S",
                            style: GoogleFonts.playfairDisplay(
                              color: Theme.of(context).colorScheme.primary,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: const Icon(Icons.mail),
                          onTap: () => {
                            Navigator.pop(context),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MessagesDashboard(),
                              ),
                            ),
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: ListTile(
                          title: Text(
                            "B L O G S",
                            style: GoogleFonts.playfairDisplay(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          leading: const Icon(Icons.rss_feed_rounded),
                          onTap: () => {
                            Navigator.pop(context),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BlogPostAdmin(),
                              ),
                            ),
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
