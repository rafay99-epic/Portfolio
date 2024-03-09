// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafay_portfolio/admin/frontend/pages/messages/archieve.dart';
import 'package:rafay_portfolio/admin/frontend/pages/messages/inbox.dart';
import 'package:rafay_portfolio/admin/frontend/widgets/admin_drawer.dart';

class MessagesDashboard extends StatelessWidget {
  const MessagesDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MyDrawerAdmin(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Message Dashboard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Image in the Rown

            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
              child: FaIcon(
                FontAwesomeIcons.envelopeOpenText,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            Text(
              "Message Dashboard",
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

            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 600.0,
                  right: 600.0,
                  top: 20.0,
                  bottom: 20.0,
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //card Inbox Messages
                    SizedBox(
                      width: 300,
                      height: 380,
                      child: GestureDetector(
                        onTap: () {
                          //redirect Logic
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InboxMessages(),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/image/contactMe.png",
                                width: 300,
                                height: 300,
                              ),
                              Text(
                                "Inbox Messages",
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
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    //card Archieve Messages Messages
                    SizedBox(
                      width: 300,
                      height: 380,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ArchiveMessages(),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/image/blog.png",
                                width: 300,
                                height: 300,
                              ),
                              Text(
                                "Archive Messages",
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
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            )

            // Card number 2: Blog page

            //Card Numbner 3: Logout
          ],
        ),
      ),
    );
  }
}
