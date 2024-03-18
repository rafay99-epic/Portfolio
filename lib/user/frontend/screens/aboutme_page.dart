import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafay_portfolio/user/frontend/views/aboutMe.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.background,
    ));
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
