import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  static const _animation = 'assets/animation/jar-loading.json';
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final progress = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    controller.addListener(() {
      setState(() {
        progress.value = controller.value;
      });
      if (controller.value >= 1.0) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: const HomePage(),
            type: PageTransitionType.fade,
            duration: const Duration(seconds: 1, milliseconds: 50),
          ),
        );
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.background,
    ));
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              SplashScreen._animation,
              controller: controller,
              onLoaded: (composition) {
                controller.duration = composition.duration;
              },
              repeat: true,
              alignment: Alignment.center,
              width: isMobile ? MediaQuery.of(context).size.width * 0.8 : null,
            ),
            SizedBox(
              height: 4.0,
              width: isMobile
                  ? MediaQuery.of(context).size.width * 0.8
                  : MediaQuery.of(context).size.width * 0.1,
              child: LinearProgressIndicator(
                value: progress.value,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
