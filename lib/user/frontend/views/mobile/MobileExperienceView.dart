// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class MobileExperienceView extends StatefulWidget {
  const MobileExperienceView({super.key});

  @override
  _MobileExperienceViewState createState() => _MobileExperienceViewState();
}

class _MobileExperienceViewState extends State<MobileExperienceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => throw Exception(),
          child: const Text("Throw Test Exception"),
        ),
      ),
    );
  }
}
