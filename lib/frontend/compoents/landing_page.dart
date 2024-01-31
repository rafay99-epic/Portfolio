import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //aNIMATED TEXT KIT
  Widget buildAnimatedText(String text, double size) {
    return DefaultTextStyle(
      softWrap: true,
      maxLines: 1,
      textAlign: TextAlign.left,
      style: GoogleFonts.roboto(
        fontSize: size,
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(text),
        ],
      ),
    );
  }

  //icons Button for Social Media
  IconButton socialMediaButton(IconData icon, String url) {
    return IconButton(
      color: Theme.of(context).colorScheme.primary,
      icon: FaIcon(icon),
      onPressed: () async {
        if (await canLaunchUrlString(url)) {
          await launchUrlString(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }

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
                    buildAnimatedText("Hi There !", 70.0),
                    buildAnimatedText("I'm Abdul Rafay", 70.0),
                    buildAnimatedText(
                        "Flutter Developer & Software Engineer", 20.0),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        socialMediaButton(FontAwesomeIcons.linkedin,
                            'https://www.linkedin.com/in/abdul-rafay1999/'),
                        socialMediaButton(FontAwesomeIcons.instagram,
                            'https://www.instagram.com/abdul_rafay99/'),
                        socialMediaButton(FontAwesomeIcons.twitter,
                            'https://twitter.com/future_insight9'),
                        socialMediaButton(FontAwesomeIcons.upwork,
                            'https://www.upwork.com/freelancers/~018c78c37a53bf3cac'),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/contact');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                      child: const Text("Hire ME"),
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
