import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import 'package:rafay_portfolio/constants/widgets/text/animatedtext.dart';
import 'package:rafay_portfolio/constants/widgets/text/textstyle.dart';
import 'package:universal_html/html.dart' as html;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class AboutMe extends StatefulWidget {
  const AboutMe({super.key});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Container(
          margin: const EdgeInsets.all(15.0),
          child: isMobile ? _buildMobileLayout() : _buildWebLayout(),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildChildren(isMobile: true),
    );
  }

  Widget _buildWebLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildChildren(isMobile: false),
    );
  }

  List<Widget> _buildChildren({required bool isMobile}) {
    return [
      if (isMobile) const SizedBox(height: 50),
      if (!isMobile)
        Flexible(
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset(
                "assets/image/about_me/about_me.jpg",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      if (isMobile)
        const CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/image/favicon.png'),
          backgroundColor: Colors.transparent,
        ),
      Flexible(
        fit: FlexFit.tight,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedTextBuilder(
                text: "So, who am I?",
                size: isMobile ? 36.0 : 72.0,
              ),
              const SizedBox(
                height: 15.0,
              ),
              StyledText(
                textAlign: TextAlign.justify,
                text:
                    "I'm a Full Stack Flutter Developer with a year's experience, transitioning from Machine Learning to crafting intuitive web experiences. Currently freelancing on platforms like Upwork, I deliver solutions that exceed client expectations",
                fontSize: 18.0,
                boldWords: const ['Full', 'Stack', 'Flutter', 'Developer'],
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                height: 25.0,
              ),
              StyledText(
                text:
                    "Beyond code, I find joy in life's simple pleasures – sipping coffee, engaging in video game battles, and embracing the challenge of new experiences. This holistic approach recharges my creativity and enriches my problem-solving perspective",
                fontSize: 18.0,
                underline: false,
                bold: false,
                textAlign: TextAlign.justify,
                boldWords: const [],
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                height: 25.0,
              ),
              if (!isMobile)
                StyledText(
                  text:
                      "In my free time, I'm passionate about continuous learning. Thriving on the tech industry's dynamic challenges, I expand my skill set, always seeking growth. Let's collaborate and create something extraordinary!",
                  fontSize: 18.0,
                  underline: false,
                  bold: false,
                  textAlign: TextAlign.justify,
                  boldWords: const [],
                  color: Theme.of(context).colorScheme.primary,
                ),
              const SizedBox(height: 15),
              Center(
                child: TextButton.icon(
                  onPressed: () async {
                    if (kIsWeb) {
                      html.AnchorElement anchorElement =
                          html.AnchorElement(href: 'assets/pdf/resume.pdf');
                      anchorElement.download = 'resume.pdf';
                      anchorElement.click();
                    } else {
                      var tempDir = await getTemporaryDirectory();
                      String fullPath = "${tempDir.path}/resume.pdf";
                      ByteData data =
                          await rootBundle.load('assets/pdf/resume.pdf');
                      List<int> bytes = data.buffer
                          .asUint8List(data.offsetInBytes, data.lengthInBytes);
                      await File(fullPath).writeAsBytes(bytes, flush: true);
                      OpenFile.open(fullPath);
                    }
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
                  label: const Text("My Resume"),
                  icon: const Icon(Icons.download_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }
}
