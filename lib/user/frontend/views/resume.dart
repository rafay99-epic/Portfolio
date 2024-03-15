import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafay_portfolio/user/frontend/widgets/ExperiencesCard.dart';
import 'package:rafay_portfolio/user/frontend/widgets/animatedtext.dart';

class Resume extends StatefulWidget {
  const Resume({super.key});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll Down
  void _smoothScrollDown() {
    _scrollController.animateTo(
      _scrollController.offset +
          300, // Change this value to control how much you want to scroll down
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  //Scroll Top
  void _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 25, bottom: 30, left: 30),
              child: AnimatedTextBuilder(
                text: "Experiences",
                size: 55.0,
                underline: true,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 90.0,
                  vertical: 30.0,
                ),
                child: GridView.count(
                  controller: _scrollController,
                  crossAxisCount: 1,
                  childAspectRatio: 5.0,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                  children: const <Widget>[
                    ExperienceCard(
                      companyName: 'Daxno Technology',
                      position: 'Mobile Application Developer',
                      employmentTime: 'Feb,05 2024 - Now',
                      toolsUsed: [
                        "Flutter",
                        "VS Code",
                        "Java",
                        "Dart",
                        "Firebase",
                        "Emulator"
                      ],
                      jobRole: [
                        "Building Stunning looking Android Applications",
                        "Testing Multiple Applications",
                        "making sure the production does not goes down"
                      ],
                    ),
                    ExperienceCard(
                      companyName: "Swam Technology",
                      position: "Machine Learning Engineer",
                      employmentTime: "Sep,2022 - Dec, 2023",
                      toolsUsed: [
                        "Python",
                        "Flusk",
                        "SQL Lite",
                        "MongoDB",
                        "Git",
                        "TensorFlow",
                      ],
                      jobRole: [
                        "Expert in software design and machine learning model development",
                        "Specialized in text analysis for abusive language detection",
                        "Proven ability to apply machine learning to real-world problems",
                        "Versatile skill set that bridges software engineering and advanced analytics."
                      ],
                    ),
                    ExperienceCard(
                      companyName: "Swam Technology",
                      position: "Full Stack App Developer",
                      employmentTime: "Sep,2022 - Dec, 2023",
                      toolsUsed: [
                        "HTML5",
                        "JavaScript",
                        "React",
                        "NodeJs",
                        "MongoDB",
                        "Firebase",
                      ],
                      jobRole: [
                        "Incorporated design principles to enhance navigation and readability.",
                        "Implemented user-friendly CMS for law firm.",
                        "Empowered non-technical users to manage website content seamlessly."
                            "Ensured intuitive design for easy content updates."
                      ],
                    ),
                    ExperienceCard(
                      companyName: "Innovation Tech",
                      position: "Intern",
                      employmentTime: "2021",
                      toolsUsed: [
                        "Java",
                        "XML",
                        "Figma",
                        "Firebase",
                        "SQL Lite"
                      ],
                      jobRole: [
                        "Code review and testing responsibilities.",
                        "Design of multiple user interfaces.",
                        "Acquisition of significant knowledge through project involvement.",
                        "Extensive test writing for various applications."
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            focusColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.background,
            onPressed: _smoothScrollToTop,
            heroTag: "btn1",
            enableFeedback: true,
            child: const Icon(
              FontAwesomeIcons.arrowUp,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            focusColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.background,
            onPressed: _smoothScrollDown,
            enableFeedback: true,
            heroTag: "btn2",
            child: const Icon(
              FontAwesomeIcons.arrowDown,
            ),
          ),
        ],
      ),
    );
  }
}
