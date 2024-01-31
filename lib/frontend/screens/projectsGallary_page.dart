import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/compoents/MyNavBar.dart';

class ProjectGalleryPage extends StatelessWidget {
  const ProjectGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyNavBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
