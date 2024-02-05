import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Page404 extends StatefulWidget {
  const Page404({super.key});

  @override
  State<Page404> createState() => _Page404State();
}

class _Page404State extends State<Page404> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "404 Error",
                          style: TextStyle(
                            fontSize: 70.0,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "Oops! Something went wrong. The page you're looking for isn't here.",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Lottie.asset(
                    'assets/animation/404-new.json',
                    height: 500,
                    width: 500,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
