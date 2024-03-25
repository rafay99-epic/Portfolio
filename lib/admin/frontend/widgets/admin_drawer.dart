import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafay_portfolio/admin/backend/auth/authService.dart';
import 'package:rafay_portfolio/admin/frontend/pages/article/articles.dart';
import 'package:rafay_portfolio/admin/frontend/pages/dashboardPage.dart';
import 'package:rafay_portfolio/admin/frontend/view/MessageDashboard.dart';

class MyDrawerAdmin extends StatefulWidget {
  const MyDrawerAdmin({super.key});

  @override
  State<MyDrawerAdmin> createState() => _MyDrawerAdminState();
}

class _MyDrawerAdminState extends State<MyDrawerAdmin>
    with TickerProviderStateMixin {
  //autho controller for logout service
  final AuthService _authService = AuthService();

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
              backgroundColor: Theme.of(context).colorScheme.background,
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
                            "C O N T A C T  M E S S A G E S",
                            style: GoogleFonts.playfairDisplay(
                              color: Theme.of(context).colorScheme.primary,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: const Icon(Icons.mail),
                          onTap: () => {
                            //Closing the drawer and opening the Setting Page
                            Navigator.pop(context),
                            //logic for redirect to get content me informatio
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
                            //Closing the drawer and opening the Setting Page
                            Navigator.pop(context),

                            //Opening the Setting Page
                            // logic for redirect to get content me informatio
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
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
                    child: ListTile(
                      title: Text(
                        "L O G O U T",
                        style: GoogleFonts.playfairDisplay(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      leading: const Icon(Icons.logout_rounded),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Confirm Logout',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: const Text(
                                'Do you want to log out?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              actions: <Widget>[
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      foregroundColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      await _authService.signOut();
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        '/admin',
                                      ); // Redirect to the login page
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
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
