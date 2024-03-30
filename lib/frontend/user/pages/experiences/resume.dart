import 'package:flutter/material.dart';
import 'package:rafay_portfolio/constants/screensSize/screentype.dart';
import 'package:rafay_portfolio/constants/scrollAnimation/button_scroll.dart';
import 'package:rafay_portfolio/frontend/user/class/job_experience_data.dart';
import 'package:rafay_portfolio/constants/widgets/floating_button.dart';
import 'package:rafay_portfolio/frontend/user/pages/experiences/widget/ExperiencesCard.dart';
import 'package:rafay_portfolio/constants/widgets/animatedtext.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Resume extends StatefulWidget {
  const Resume({Key? key}) : super(key: key);

  @override
  State<Resume> createState() => _ResumeState();
}

//-------------------------------------
// Passing the ScrollControllerMixin
//-------------------------------------
class _ResumeState extends State<Resume> with ScrollControllerMixin {
  //--------------
  // Job List
  //--------------
  List<Job> jobs = _getJobs();
  //------------------
  // Job List: Data
  //------------------
  static List<Job> _getJobs() {
    return [
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
  }

  //--------------------
  // Main Build Method
  //--------------------

  @override
  Widget build(BuildContext context) {
    ScreenType screenType = ScreenType(MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      //--------------
      // Widget Body
      //--------------
      body: _buildBody(context, screenType),
      //-------------------------
      // Floating Action Button
      //-------------------------

      floatingActionButton: MediaQuery.of(context).size.width > 600
          ? buildFloatingButton(context, smoothScrollToTop, smoothScrollDown)
          : null,
    );
  }

  //-------------------------
  // Body Build Method
  //-------------------------
  Widget _buildBody(BuildContext context, ScreenType screenType) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          //-------------------------
          // Header
          //-------------------------
          _buildHeader(context, screenType),
          //-------------------------
          // Jobs Build
          //-------------------------
          _buildJobs(context, screenType),
        ],
      ),
    );
  }

  //-------------------------
  // Header Build Method
  //-------------------------
  Widget _buildHeader(BuildContext context, ScreenType screenType) {
    return Align(
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
    );
  }

  //-------------------------
  // Jobs Build Method
  //-------------------------
  Widget _buildJobs(BuildContext context, ScreenType screenType) {
    return Padding(
      padding: screenType.isMobile
          ? const EdgeInsets.only(left: 0, right: 0)
          : const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: List.generate(
          jobs.length,
          //-------------------------
          // Job Cards
          //-------------------------
          (index) => _buildJobCard(context, screenType, index),
        ),
      ),
    );
  }

  //-------------------------
  // Build Job Card Method
  //-------------------------
  Widget _buildJobCard(BuildContext context, ScreenType screenType, int index) {
    if (screenType.isMobile) {
      return JobCard(job: jobs[index]);
    } else {
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
    }
  }
}
