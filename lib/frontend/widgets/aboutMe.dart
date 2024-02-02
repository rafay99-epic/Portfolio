import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({super.key});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    //text Style Code
    Widget styledText(
      String text,
      double fontSize, {
      List<String> boldWords = const [],
      bool underline = false,
      bool bold = false,
    }) {
      List<String> words = text.split(' ');
      return RichText(
        text: TextSpan(
          children: words.map((word) {
            if (boldWords.contains(word)) {
              return TextSpan(
                text: '$word ',
                style: TextStyle(
                  decoration: underline ? TextDecoration.underline : null,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              );
            } else {
              return TextSpan(
                text: '$word ',
                style: TextStyle(
                  decoration: underline ? TextDecoration.underline : null,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  fontSize: fontSize,
                ),
              );
            }
          }).toList(),
        ),
      );
    }

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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(55.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    styledText("About Me", 72.0, underline: false, bold: true),
                    const SizedBox(
                      height: 15.0,
                    ),
                    styledText(
                      "I'm a Full Stack Flutter Developer with a year's experience, transitioning from Machine Learning to crafting intuitive web experiences. Currently freelancing on platforms like Upwork, I deliver solutions that exceed client expectations",
                      18.0,
                      boldWords: ['Full', 'Stack', 'Flutter', 'Developer'],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    styledText(
                      "Beyond code, I find joy in life's simple pleasures – sipping coffee, engaging in video game battles, and embracing the challenge of new experiences. This holistic approach recharges my creativity and enriches my problem-solving perspective",
                      18.0,
                      underline: false,
                      bold: false,
                      boldWords: [],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    styledText(
                      "In my free time, I'm passionate about continuous learning. Thriving on the tech industry's dynamic challenges, I expand my skill set, always seeking growth. Let's collaborate and create something extraordinary!",
                      18.0,
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
