import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Lottie.asset('assets/animation/loader.json'),
      ),
    );
  }
}
