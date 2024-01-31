// ignore: file_names
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rafay_portfolio/frontend/compoents/my_drawer.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: <Widget>[
          const MyNavBar(),
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
      ),
    );
  }
}
