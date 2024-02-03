import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/widgets/ProjectGallery.dart';

class ProjectGalleryPage extends StatelessWidget {
  const ProjectGalleryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const ProjectGallery(),
    );
  }
}
