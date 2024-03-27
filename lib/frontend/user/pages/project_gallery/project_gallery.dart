// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:rafay_portfolio/constants/screensSize/screentype.dart';
import 'package:rafay_portfolio/constants/widgets/animatedtext.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/widgets/floating_button.dart';
import 'package:rafay_portfolio/frontend/user/pages/project_gallery/components/project_card.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProjectGridView extends StatefulWidget {
  const ProjectGridView({Key? key}) : super(key: key);

  @override
  _ProjectGridViewState createState() => _ProjectGridViewState();
}

class _ProjectGridViewState extends State<ProjectGridView> {
  //----------------------
  //Controllers
  //----------------------
  late ScrollController _scrollController;

  //----------------------
  //init State & Dispose
  //----------------------
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

  //------------------------------
  // Scroll Up & Down Functions
  //------------------------------

  void _smoothScrollDown() {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  //----------------------
  // Main Build Widget
  //----------------------

  @override
  Widget build(BuildContext context) {
    //----------------------
    // All the Projects
    //----------------------
    final projects = _buildProjects();

    //----------------------
    // Screen Types
    //----------------------
    final screenType = ScreenType(MediaQuery.of(context).size.width);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //----------------------
            // Header of the File
            //----------------------
            _buildHeader(screenType),
            //----------------------
            // Project Grid
            //----------------------
            _buildProjectsGrid(projects),
          ],
        ),
      ),
      //----------------------
      // Floating Button
      //----------------------
      floatingActionButton: screenType.isMobile
          ? null
          : buildFloatingButton(context, _smoothScrollToTop, _smoothScrollDown),
    );
  }

  //----------------------
  // Build Header Widget
  //----------------------
  Widget _buildHeader(ScreenType screenType) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenType.isMobile ? 50.0 : 25.0,
        bottom: screenType.isMobile ? 0 : 30.0,
        left: screenType.isMobile ? 10 : 0,
      ),
      child: AnimatedTextBuilder(
        text: "Some Things I've Build",
        size: screenType.isMobile ? 40.0 : 72.0,
        underline: true,
      ),
    );
  }

  //----------------------
  // Build Projects Grid
  //----------------------
  Widget _buildProjectsGrid(List<ProjectCard> projects) {
    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          //-----------------------------
          // Calculate Cross Axis Count
          //-----------------------------
          final crossAxisCount = _calculateCrossAxisCount(constraints);
          //-----------------------------
          // Calculate AspectRatio
          //-----------------------------
          final childAspectRatio =
              _calculateChildAspectRatio(constraints, crossAxisCount);

          return GridView.builder(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) => projects[index],
          );
        },
      ),
    );
  }

  //-----------------------------
  // Calculate Cross Axis Count
  //-----------------------------
  int _calculateCrossAxisCount(BoxConstraints constraints) {
    if (constraints.maxWidth < 600) {
      return 1;
    } else if (constraints.maxWidth < 900) {
      return 2;
    } else if (constraints.maxWidth < 1200) {
      return 3;
    } else {
      return 4;
    }
  }

  //-----------------------------
  // Calculate AspectioRatio
  //-----------------------------
  double _calculateChildAspectRatio(
      BoxConstraints constraints, int crossAxisCount) {
    double screenHeight = MediaQuery.of(context).size.height;
    double gridItemWidth = constraints.maxWidth / crossAxisCount;

    if (constraints.maxWidth < 600) {
      return kIsWeb
          ? gridItemWidth / (screenHeight / 1.5)
          : gridItemWidth / (screenHeight / 1.2);
    } else if (constraints.maxWidth < 900) {
      return kIsWeb
          ? gridItemWidth / (screenHeight / 1.5)
          : gridItemWidth / (screenHeight / 1.2);
    } else if (constraints.maxWidth < 1200) {
      return kIsWeb
          ? gridItemWidth / (screenHeight / 1.5)
          : gridItemWidth / (screenHeight / 1.2);
    } else {
      return kIsWeb
          ? gridItemWidth / (screenHeight / 1.5)
          : gridItemWidth / (screenHeight / 1.2);
    }
  }

  //-----------------------------
  // List of All Projects
  //-----------------------------
  List<ProjectCard> _buildProjects() {
    return [
      const ProjectCard(
        title: 'Dienstleisto',
        description:
            'Dienstleisto is a Flutter-based job-finding app designed to simplify your job search. With intuitive features and a user-friendly interface, find your next opportunity hassle-free.',
        imageUrl: 'assets/image/DienstleistoIntroScreen.png',
        technologies: [
          'Flutter',
          'Firebase',
          'Dart',
          'VS-code',
          "Git",
          "GitHub",
          "Postman",
          "Test Magic"
        ],
        githubLink: 'https://github.com/rafay99-epic/Dienstleistro',
        deployedLink: '',
      ),
      const ProjectCard(
        title: 'Check Pont',
        description:
            'Check Point: Your sleek, Flutter-powered companion for seamless task management. Effortlessly create, organize, and conquer your to-do list with intuitive ease. Simplify your productivity and achieve more with Check Point.',
        imageUrl: 'assets/image/CoverPageCheckPoint.png',
        technologies: [
          'Flutter',
          'Firebase',
          'Dart',
          'VS-code',
          "Local Storage Support",
          "Postman",
          "Test Magic"
        ],
        githubLink: 'https://github.com/rafay99-epic/CheckPoint',
        deployedLink: '',
      ),
      const ProjectCard(
        title: 'Chess Master',
        description:
            "Dive into the strategic world of chess with this Flutter-powered game. Challenge friends 👥, master the art of checkmate! Your mobile chess arena awaits. ♞🌟",
        imageUrl: 'assets/image/chessMaster2.png',
        technologies: [
          'Flutter',
          'Firebase',
          'Dart',
          "Postman",
          "Test Magic",
          "Git",
          "GitHub",
        ],
        githubLink: 'https://github.com/rafay99-epic/ChessMaster',
        deployedLink: '',
      ),
      const ProjectCard(
        title: 'Future Insight Flutter Application',
        description:
            "Explore insightful content effortlessly with the 'Clean UI Future Insight' Android App. Designed in Flutter for a seamless and immersive experience.",
        imageUrl: 'assets/image/Thumbnail.png',
        technologies: [
          'Flutter',
          'Firebase',
          'Dart',
          'VS-code',
          "Google Play Store",
          "Git",
          "GitHub",
          "Postman",
          "Test Magic"
        ],
        githubLink: "https://github.com/FutureInsightTech/InsightfulFlutterApp",
        deployedLink: '',
      ),
      const ProjectCard(
        title: 'Future Insight Website',
        description:
            "Explore cutting-edge insights on the 'Future Insight' Blog. Crafted with Node.js, Hugo, and deployed on Netlify for a seamless experience.",
        imageUrl: 'assets/image/future-insight.png',
        technologies: [
          'Hugo',
          'NodeJs',
          'Markdown',
          'VS-code',
          "Git",
          "TinaCMS",
          "Netlify",
          "Playwrite",
          "SEO Optimization"
        ],
        githubLink: "https://github.com/FutureInsightTech/FutureIsnight-Site",
        deployedLink: '',
      ),
      const ProjectCard(
        title: 'Shafiq Law Chamber',
        description:
            "Explore Shafiq Law Chamber's expertise on our seamlessly crafted website. Powered by Hugo and Node.js, it ensures a professional and user-friendly online presence.",
        imageUrl: 'assets/image/shafiqLawChamber.png',
        technologies: [
          'Hugo',
          'NodeJs',
          'Markdown',
          'VS-code',
          "Git",
          "TinaCMS",
          "Netlify",
          "Playwrite",
          "SEO Optimization"
        ],
        githubLink: "https://github.com/FutureInsightTech/Shafiq-Law-Chamber",
        deployedLink: 'https://shafiqlawchamber.com/',
      ),
      const ProjectCard(
        title: 'Smart Parking Assistant',
        description:
            "Explore Parking Assistant: a reservation solution with ML recognition. Powered by Node.js, Python, and JavaScript, it streamlines operations for efficient parking management.",
        imageUrl: 'assets/image/ParkingAssistant.png',
        technologies: [
          "HTML",
          "Netlify",
          "CSS",
          "Python",
          "JavaScript",
          "Arudino",
          'NodeJs',
          'VS-code',
          "Netlify",
          "Playwrite",
        ],
        githubLink: "https://github.com/FutureInsightTech/Parking-Assistant",
        deployedLink: '',
      ),
    ];
  }
}
