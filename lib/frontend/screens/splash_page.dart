import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  static const _animation = 'assets/animation/Future_Insight.json';

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
              fit: BoxFit.contain,
              repeat: true,
              alignment: Alignment.center,
            ),
            // const SizedBox(height: 20),
            SizedBox(
              height: 5.0,
              width: MediaQuery.of(context).size.width *
                  0.3, // Adjust this value to change the width of the progress bar
              child: LinearProgressIndicator(
                value: progress.value,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
