import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafay_portfolio/constants/screensSize/screentype.dart';
import 'package:rafay_portfolio/frontend/user/pages/contact_me/contact_me.dart';

class ContactMePage extends StatelessWidget {
  const ContactMePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenType = ScreenType(MediaQuery.of(context).size.width);

    if (screenType.isMobile) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.surface,
      ));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const ContactMe(),
    );
  }
}
