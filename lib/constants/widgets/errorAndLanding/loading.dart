import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:rafay_portfolio/constants/screensSize/screentype.dart';

Widget buildLoadingIndicator(BuildContext context) {
  ScreenType screenType = ScreenType(MediaQuery.of(context).size.width);
  return Center(
    child: Padding(
      padding: screenType.isMobile
          ? const EdgeInsets.only(left: 10.0, right: 10.0)
          : const EdgeInsets.only(left: 400.0, right: 400.0),
      child: FAProgressBar(
        currentValue: 100,
        size: 10,
        backgroundColor: Theme.of(context).colorScheme.surface,
        progressColor: Theme.of(context).colorScheme.inversePrimary,
        maxValue: 100,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
}
