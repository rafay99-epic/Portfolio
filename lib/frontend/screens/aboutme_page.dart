import 'package:flutter/material.dart';

import 'package:rafay_portfolio/frontend/compoents/MyNavBar.dart';
import 'package:rafay_portfolio/frontend/compoents/aboutMe.dart';
import 'package:rafay_portfolio/frontend/compoents/footer.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyNavBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: AboutMe(),
          ),
          Footer(),
        ],
      ),
    );
  }
}
