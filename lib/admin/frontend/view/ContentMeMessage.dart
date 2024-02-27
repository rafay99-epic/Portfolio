import 'package:flutter/material.dart';
import 'package:rafay_portfolio/admin/frontend/widgets/admin_drawer.dart';

class ContactMessages extends StatefulWidget {
  const ContactMessages({super.key});

  @override
  State<ContactMessages> createState() => _ContactMessagesState();
}

class _ContactMessagesState extends State<ContactMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawerAdmin(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
