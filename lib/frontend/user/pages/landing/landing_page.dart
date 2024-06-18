// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'package:rafay_portfolio/constants/widgets/ultis/SocialMediaIcon.dart';
import 'package:rafay_portfolio/constants/widgets/text/animatedtext.dart';
import 'package:rafay_portfolio/frontend/user/screens/contact_me_page.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //main Widget
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: isMobile
            ? Column(
                // Use Column for mobile layout
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildChildren(context, isMobile),
              )
            : Row(
                // Use Row for web layout
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildChildren(context, isMobile),
              ),
      ),
      floatingActionButton: isMobile
          ? FloatingActionButton(
              onPressed: () async {
                const url = 'https://wa.me/03035650798?text=Hello';
                if (await canLaunch(url)) {
                  try {
                    await launch(url);
                  } catch (e) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactMePage(),
                      ),
                    );
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactMePage(),
                    ),
                  );
                }
              },
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              child: const Icon(FontAwesomeIcons.message),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  List<Widget> _buildChildren(BuildContext context, bool isMobile) {
    return [
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            left: isMobile ? 15.0 : 55.0,
            top: isMobile ? 50.0 : 0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              AnimatedTextBuilder(
                text: "Hi There !",
                size: isMobile ? 45.0 : 72.0,
              ),
              AnimatedTextBuilder(
                text: "I'm Abdul Rafay",
                size: isMobile ? 45.0 : 72.0,
              ),
              const AnimatedTextBuilder(
                text: "Software Engineer | Full Stack & Flutter Developer",
                size: 20.0,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SocialMediaButton(
                    icon: FontAwesomeIcons.linkedin,
                    url: 'https://www.linkedin.com/in/abdul-rafay1999/',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SocialMediaButton(
                    icon: FontAwesomeIcons.instagram,
                    url: 'https://www.instagram.com/abdul_rafay99/',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SocialMediaButton(
                    icon: FontAwesomeIcons.twitter,
                    url: 'https://twitter.com/future_insight9',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SocialMediaButton(
                    icon: FontAwesomeIcons.upwork,
                    url:
                        'https://www.upwork.com/freelancers/~018c78c37a53bf3cac',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              if (!isMobile)
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/contact');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.all(20.0),
                  ),
                  label: const Text("Hire Me!"),
                  icon: const Icon(Icons.send_rounded),
                ),
              if (isMobile)
                Lottie.asset(
                  'assets/animation/rafay_animation.json',
                ),
            ],
          ),
        ),
      ),
      if (!isMobile)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Lottie.asset(
              'assets/animation/rafay_animation.json',
              width: 10000,
              height: 10000,
            ),
          ),
        ),
    ];
  }
}
