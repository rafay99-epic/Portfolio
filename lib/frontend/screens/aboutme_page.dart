import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/widgets/aboutMe.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: AboutMe(),
          ),
        ],
      ),
    );
  }
}
