import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafay_portfolio/frontend/user/pages/contact_me/contact_me.dart';

class ContactMePage extends StatelessWidget {
  const ContactMePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.background,
    ));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const ContactMe(),
    );
  }
}
