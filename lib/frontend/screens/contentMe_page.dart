// ignore: file_names
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/views/ContactMe.dart';

class ContactMePage extends StatefulWidget {
  const ContactMePage({super.key});

  @override
  State<ContactMePage> createState() => _ContactMePageState();
}

class _ContactMePageState extends State<ContactMePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const ContactMe(),
    );
  }
}
