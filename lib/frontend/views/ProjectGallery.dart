import 'package:flutter/material.dart';

import 'package:rafay_portfolio/frontend/widgets/ProjectCards.dart';
import 'package:rafay_portfolio/frontend/widgets/animatedtext.dart';

class ProjectGallery extends StatefulWidget {
  const ProjectGallery({super.key});

  @override
  State<ProjectGallery> createState() => _ProjectGalleryState();
}

class _ProjectGalleryState extends State<ProjectGallery> {
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
                  text: "Some Things I've Build",
                  size: 55.0,
                  underline: true,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 80.0,
                    vertical: 50.0,
                  ),
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 2.3, //lower value
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                    children: const <Widget>[
                      ProjectCard(
                        text: 'Simple Thread',
                        HeadingFontSize: 22,
                        DescriptionFontSize: 16,
                        description:
                            "Built a clean Flutter Chat App with real-time sync using Firebase for effortless and enjoyable communication.",
                        deploedlink: "",
                        githublink:
                            "https://github.com/rafay99-epic/SimpleThread",
                        technologyNames: ["Flutter", "Firebase", "Dart"],
                      ),
                      ProjectCard(
                        text: 'Check Point',
                        HeadingFontSize: 22,
                        DescriptionFontSize: 16,
                        description:
                            "Streamline note-taking with a Flutter and Firebase app for efficient and accessible organization.",
                        deploedlink: "",
                        githublink:
                            "https://github.com/rafay99-epic/CheckPoint",
                        technologyNames: ["Flutter", "Firebase", "Dart"],
                      ),
                      ProjectCard(
                        text: 'Chess Master',
                        HeadingFontSize: 22,
                        DescriptionFontSize: 16,
                        description:
                            "Experience chess simplicity with a visually appealing and user-friendly game crafted using Flutter.",
                        deploedlink: "",
                        githublink:
                            "https://github.com/rafay99-epic/ChessMaster",
                        technologyNames: ["Flutter", "Firebase", "Dart"],
                      ),
                      ProjectCard(
                        text: "Future Insight",
                        HeadingFontSize: 22,
                        DescriptionFontSize: 16,
                        description:
                            "Explore cutting-edge insights on the 'Future Insight' Blog. Crafted with Node.js, Hugo, and deployed on Netlify for a seamless experience.",
                        deploedlink: "https://future-insight.blog/",
                        githublink:
                            "https://github.com/FutureInsightTech/FutureIsnight-Site",
                        technologyNames: ["NodeJS", "Hugo", "Netlify"],
                      ),
                      ProjectCard(
                        text: 'Future Insight App',
                        HeadingFontSize: 22,
                        DescriptionFontSize: 16,
                        description:
                            "Explore insightful content effortlessly with the 'Clean UI Future Insight' Android App. Designed in Flutter for a seamless and immersive experience.",
                        deploedlink: "",
                        githublink:
                            "https://github.com/FutureInsightTech/InsightfulFlutterApp",
                        technologyNames: ["Flutter", "Firebase", "Dart"],
                      ),
                      ProjectCard(
                        text: 'Shafiq Law Chamber',
                        HeadingFontSize: 22,
                        DescriptionFontSize: 16,
                        description:
                            "Explore Shafiq Law Chamber's expertise on our seamlessly crafted website. Powered by Hugo and Node.js, it ensures a professional and user-friendly online presence.",
                        deploedlink: "https://shafiqlawchamber.com/",
                        githublink:
                            "https://github.com/FutureInsightTech/Shafiq-Law-Chamber",
                        technologyNames: ["NodeJS", "Hugo", "Netlify"],
                      ),
                      ProjectCard(
                        text: 'Cyber Detection',
                        HeadingFontSize: 22,
                        DescriptionFontSize: 16,
                        description:
                            "Defend EV Stations with ML and Python. Our system detects and safeguards against cyber threats, ensuring secure charging infrastructure for operators and users.",
                        deploedlink: "",
                        githublink:
                            "https://github.com/FutureInsightTech/Detect-FDIA-SVM",
                        technologyNames: ["Python", "Machine Learning"],
                      ),
                      ProjectCard(
                        text: 'Parking Assistant',
                        HeadingFontSize: 22,
                        DescriptionFontSize: 16,
                        description:
                            "Explore Parking Assistant: a reservation solution with ML recognition. Powered by Node.js, Python, and JavaScript, it streamlines operations for efficient parking management.",
                        deploedlink: "",
                        githublink:
                            "https://github.com/FutureInsightTech/Parking-Assistant",
                        technologyNames: [
                          "NodeJS",
                          "HTML",
                          "Netlify",
                          "CSS",
                          "Python"
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
