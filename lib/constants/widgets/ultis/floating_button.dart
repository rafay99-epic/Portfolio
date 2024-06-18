//--------------------------
//Floating Button for web
//--------------------------

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Column buildFloatingButton(
  BuildContext context,
  VoidCallback smoothScrollToTop,
  VoidCallback smoothScrollDown,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        focusColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.surface,
        onPressed: smoothScrollToTop,
        heroTag: "btn1",
        enableFeedback: true,
        child: const Icon(
          FontAwesomeIcons.arrowUp,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        focusColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.surface,
        onPressed: smoothScrollDown,
        enableFeedback: true,
        heroTag: "btn2",
        child: const Icon(
          FontAwesomeIcons.arrowDown,
        ),
      ),
    ],
  );
}
