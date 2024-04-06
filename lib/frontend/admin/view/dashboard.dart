// // ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:rafay_portfolio/backend/auth/authService.dart';
import 'package:rafay_portfolio/frontend/admin/pages/article/articles.dart';
import 'package:rafay_portfolio/frontend/admin/view/MessageDashboard.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/admin_drawer.dart';

// class Dashboard extends StatelessWidget {
//   const Dashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AuthService _authService = AuthService();
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       drawer: const MyDrawerAdmin(),
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.background,
//         title: const Text("Dashboard"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             //Image in the Rown
//             Image.asset(
//               "assets/image/favicon.png",
//               width: 200,
//               height: 200,
//             ),

//             Text(
//               "My Dashboard",
//               style: GoogleFonts.playfair(
//                 fontSize: 42,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).colorScheme.primary,
//               ),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             //Row
//             // Card Number 1: Contact Me Page
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   left: 450.0,
//                   right: 450.0,
//                   top: 20.0,
//                   bottom: 20.0,
//                 ),
//                 child: Row(
//                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     SizedBox(
//                       width: 300,
//                       height: 380,
//                       child: GestureDetector(
//                         onTap: () {
//                           //redirect Logic
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const MessagesDashboard(),
//                             ),
//                           );
//                         },
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Image.asset(
//                                 "assets/image/contactMe.png",
//                                 width: 300,
//                                 height: 300,
//                               ),
//                               Text(
//                                 "Contact Me",
//                                 style: GoogleFonts.playfair(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                   color: Theme.of(context).colorScheme.primary,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     SizedBox(
//                       width: 300,
//                       height: 380,
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               // builder: (context) => const BlogDashboard(),
//                               builder: (context) => const BlogPostAdmin(),
//                             ),
//                           );
//                         },
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Image.asset(
//                                 "assets/image/blog.png",
//                                 width: 300,
//                                 height: 300,
//                               ),
//                               Text(
//                                 "Blog Post",
//                                 style: GoogleFonts.playfair(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                   color: Theme.of(context).colorScheme.primary,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     SizedBox(
//                       width: 300,
//                       height: 380,
//                       child: GestureDetector(
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: const Text(
//                                   'Confirm Logout',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 content: const Text(
//                                   'Do you want to log out?',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 actions: <Widget>[
//                                   SizedBox(
//                                     width: double.infinity,
//                                     child: TextButton(
//                                       style: TextButton.styleFrom(
//                                         backgroundColor: Theme.of(context)
//                                             .colorScheme
//                                             .inversePrimary,
//                                         foregroundColor: Theme.of(context)
//                                             .colorScheme
//                                             .background,
//                                       ),
//                                       child: const Text(
//                                         'No',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   SizedBox(
//                                     width: double.infinity,
//                                     child: TextButton(
//                                       style: TextButton.styleFrom(
//                                         foregroundColor: Theme.of(context)
//                                             .colorScheme
//                                             .background,
//                                         backgroundColor: Theme.of(context)
//                                             .colorScheme
//                                             .inversePrimary,
//                                       ),
//                                       child: const Text(
//                                         'Yes',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       onPressed: () async {
//                                         Navigator.of(context).pop();
//                                         await _authService.signOut();
//                                         // ignore: use_build_context_synchronously
//                                         Navigator.of(context)
//                                             .pushReplacementNamed(
//                                           '/admin',
//                                         ); // Redirect to the login page
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Image.asset(
//                                 "assets/image/logout.png",
//                                 width: 300,
//                                 height: 300,
//                               ),
//                               Text(
//                                 "Logout",
//                                 style: GoogleFonts.playfair(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                   color: Theme.of(context).colorScheme.primary,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth < 600 ? 150 : 300;
    final double cardHeight = screenWidth < 600 ? 190 : 380;
    final double padding = screenWidth < 600 ? 20 : 450;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MyDrawerAdmin(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Dashboard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Image in the Rown
            Image.asset(
              "assets/image/favicon.png",
              width: 200,
              height: 200,
            ),

            Text(
              "My Dashboard",
              style: GoogleFonts.playfair(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            //Row
            // Card Number 1: Contact Me Page
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: padding,
                  vertical: 20.0,
                ),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    _buildCard(
                      context,
                      "assets/image/contactMe.png",
                      "Contact Me",
                      cardWidth,
                      cardHeight,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MessagesDashboard(),
                          ),
                        );
                      },
                    ),
                    _buildCard(
                      context,
                      "assets/image/blog.png",
                      "Blog Post",
                      cardWidth,
                      cardHeight,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BlogPostAdmin(),
                          ),
                        );
                      },
                    ),
                    _buildCard(
                      context,
                      "assets/image/logout.png",
                      "Logout",
                      cardWidth,
                      cardHeight,
                      () {
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
                                      SchedulerBinding.instance
                                          .addPostFrameCallback(
                                        (_) {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                            '/admin',
                                            (Route<dynamic> route) => false,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String imagePath, String text,
      double width, double height, VoidCallback onTap) {
    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imagePath,
                width: width,
                height: height * 0.8,
              ),
              Text(
                text,
                style: GoogleFonts.playfair(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
