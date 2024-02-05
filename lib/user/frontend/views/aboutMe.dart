import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rafay_portfolio/user/frontend/widgets/animatedtext.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({super.key});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
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
                padding: const EdgeInsets.all(25.0),
                child: Lottie.asset(
                  'assets/animation/about_me.json',
                  backgroundLoading: true,
                ),
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(55.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedTextBuilder(
                      text: "About Me",
                      size: 72.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    StyledText(
                      text:
                          "I'm a Full Stack Flutter Developer with a year's experience, transitioning from Machine Learning to crafting intuitive web experiences. Currently freelancing on platforms like Upwork, I deliver solutions that exceed client expectations",
                      fontSize: 18.0,
                      boldWords: ['Full', 'Stack', 'Flutter', 'Developer'],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    StyledText(
                      text:
                          "Beyond code, I find joy in life's simple pleasures – sipping coffee, engaging in video game battles, and embracing the challenge of new experiences. This holistic approach recharges my creativity and enriches my problem-solving perspective",
                      fontSize: 18.0,
                      underline: false,
                      bold: false,
                      boldWords: [],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    StyledText(
                      text:
                          "In my free time, I'm passionate about continuous learning. Thriving on the tech industry's dynamic challenges, I expand my skill set, always seeking growth. Let's collaborate and create something extraordinary!",
                      fontSize: 18.0,
                      underline: false,
                      bold: false,
                      boldWords: [],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
