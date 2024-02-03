import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'package:rafay_portfolio/frontend/widgets/SocialMediaIcon.dart';
import 'package:rafay_portfolio/frontend/widgets/animatedtext.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 55.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AnimatedTextBuilder(
                      text: "Hi There !",
                      size: 70.0,
                    ),
                    const AnimatedTextBuilder(
                      text: "I'm Abdul Rafay",
                      size: 70.0,
                    ),
                    const AnimatedTextBuilder(
                      text: "Flutter Developer & Software Engineer",
                      size: 20.0,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SocialMediaButton(
                          icon: FontAwesomeIcons.linkedin,
                          url: 'https://www.linkedin.com/in/abdul-rafay1999/',
                        ),
                        SocialMediaButton(
                          icon: FontAwesomeIcons.instagram,
                          url: 'https://www.instagram.com/abdul_rafay99/',
                        ),
                        SocialMediaButton(
                          icon: FontAwesomeIcons.twitter,
                          url: 'https://twitter.com/future_insight9',
                        ),
                        SocialMediaButton(
                          icon: FontAwesomeIcons.upwork,
                          url:
                              'https://www.upwork.com/freelancers/~018c78c37a53bf3cac',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/contact');
                      },
                      style: TextButton.styleFrom(
                        // ! Old Color
                        // foregroundColor: Colors.deepOrange,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        padding: const EdgeInsets.all(20.0),
                      ),
                      label: const Text("Hire Me!"),
                      icon: const Icon(Icons.send_rounded),
                    ),
                  ],
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
