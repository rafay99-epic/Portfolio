import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafay_portfolio/constants/screensSize/screentype.dart';
import 'package:rafay_portfolio/user/frontend/class/job_experience_data.dart';
import 'package:rafay_portfolio/user/frontend/pages/experiences/widget/ExperiencesCard.dart';
import 'package:rafay_portfolio/user/frontend/widgets/animatedtext.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Resume extends StatefulWidget {
  const Resume({Key? key}) : super(key: key);

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
      _scrollController.offset + 300,
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

  //data
  List<Job> jobs = [
    Job(
      companyName: 'Daxno Technology',
      position: 'Flutter Developer & Team Lead',
      employmentTime: '2nd Feb, 2024 - Present',
      roles: [
        "Building Stunning looking Android Applications",
        "Testing Multiple Applications",
        "making sure the production does not goes down"
      ],
      toolsUsed: [
        'Flutter',
        'VS Code',
        'Git',
        'Android Studio',
        'Firebase',
        'Superbase'
      ],
    ),
    Job(
      companyName: "Swam Technology",
      position: 'Machine Learning Engineer',
      employmentTime: 'Sep,2022 - Dec, 2023',
      roles: [
        "Expert in software design and machine learning model development",
        "Specialized in text analysis for abusive language detection",
        "Proven ability to apply machine learning to real-world problems",
        "Versatile skill set that bridges software engineering and advanced analytics."
      ],
      toolsUsed: [
        "Python",
        "Flusk",
        "SQL Lite",
        "MongoDB",
        "Git",
        "TensorFlow",
      ],
    ),
    Job(
      companyName: 'Swam Technology',
      position: 'Full Stack Web Developer',
      employmentTime: 'Sep,2022 - Dec, 2023',
      roles: [
        "Incorporated design principles to enhance navigation and readability.",
        "Implemented user-friendly CMS for law firm.",
        "Empowered non-technical users to manage website content seamlessly."
            "Ensured intuitive design for easy content updates."
      ],
      toolsUsed: [
        "HTML5",
        "JavaScript",
        "React",
        "NodeJs",
        "MongoDB",
        "Firebase",
      ],
    ),
    Job(
      companyName: 'Innovation Tech',
      position: 'Intern',
      employmentTime: '2021',
      roles: [
        "Code review and testing responsibilities.",
        "Design of multiple user interfaces.",
        "Acquisition of significant knowledge through project involvement.",
        "Extensive test writing for various applications."
      ],
      toolsUsed: [
        "Java",
        "XML",
        "Figma",
        "Firebase",
        "SQL Lite",
      ],
    ),
  ];

  //main widget
  @override
  Widget build(BuildContext context) {
    ScreenType screenType = ScreenType(MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: screenType.isMobile ? 50 : 25,
                  bottom: 30,
                  left: 30,
                ),
                child: AnimatedTextBuilder(
                  text: "Experiences",
                  size: screenType.isMobile ? 40.0 : 72.0,
                  underline: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Column(
                children: List.generate(
                  jobs.length,
                  (index) {
                    return TimelineTile(
                      axis: TimelineAxis.vertical,
                      alignment: TimelineAlign.manual,
                      lineXY: 0.0,
                      isFirst: index == 0,
                      isLast: index == jobs.length - 1,
                      indicatorStyle: IndicatorStyle(
                        width: 20,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      beforeLineStyle: LineStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      afterLineStyle: LineStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      endChild: JobCard(job: jobs[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: MediaQuery.of(context).size.width > 600
          ? Column(
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
            )
          : null,
    );
  }
}
