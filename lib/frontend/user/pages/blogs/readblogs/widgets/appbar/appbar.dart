import 'package:flutter/material.dart';
import 'package:rafay_portfolio/constants/screensSize/screentype.dart';

AppBar buildAppBar(BuildContext context, ValueNotifier<double> progress) {
  ScreenType screenType = ScreenType(MediaQuery.of(context).size.width);
  return AppBar(
    elevation: 0,
    automaticallyImplyLeading: false,
    leading: screenType.isMobile
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : null,
    backgroundColor: Theme.of(context).colorScheme.surface,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(2.0),
      child: ValueListenableBuilder<double>(
        valueListenable: progress,
        builder: (context, value, child) {
          return LinearProgressIndicator(
            value: value,
            backgroundColor: Theme.of(context).colorScheme.surface,
            color: Theme.of(context).colorScheme.inversePrimary,
            minHeight: 3.0,
          );
        },
      ),
    ),
  );
}
