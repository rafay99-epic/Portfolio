import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafay_portfolio/user/frontend/views/ProjectGallery.dart';

class ProjectGalleryPage extends StatelessWidget {
  const ProjectGalleryPage({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.background,
    ));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const ProjectGallery(),
    );
  }
}
