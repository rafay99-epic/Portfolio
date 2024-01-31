import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/compoents/MyNavBar.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyNavBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
