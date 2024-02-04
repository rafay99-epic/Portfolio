// ignore: file_names
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/views/resume.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Resume(),
    );
  }
}
