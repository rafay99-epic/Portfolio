import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';

Widget noInternetConnection(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.25,
          bottom: MediaQuery.of(context).size.height * 0.25,
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Lottie.asset('assets/animation/noInternet.json'),
              const SizedBox(height: 10),
              StyledText(
                text:
                    "Sorry!! To Read an Article Please Connect to the Internet",
                fontSize: 20,
                color: Theme.of(context).colorScheme.primary,
                textAlign: TextAlign.center,
                bold: true,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
