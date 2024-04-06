import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rafay_portfolio/constants/widgets/text/textstyle.dart';

Widget buildErrorWidget(BuildContext context) {
  return SingleChildScrollView(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, top: 20.0, bottom: 20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Lottie.asset('assets/animation/datanotfound.json'),
            const SizedBox(height: 10),
            StyledText(
              text: "Sorry!! No search results found. ",
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
              textAlign: TextAlign.center,
              bold: true,
            )
          ],
        ),
      ),
    ),
  );
}
