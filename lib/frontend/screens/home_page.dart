import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/compoents/MyNavBar.dart';

import 'package:rafay_portfolio/frontend/compoents/landing_page.dart';

import 'package:rafay_portfolio/frontend/compoents/footer.dart'; // Import the Footer widget

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyNavBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: LandingPage(),
          ),
          Footer(),
        ],
      ),
    );
  }
}
