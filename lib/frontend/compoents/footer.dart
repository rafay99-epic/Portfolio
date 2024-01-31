import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Made with ',
              style: TextStyle(
                fontSize: 12.0,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            Text(
              ' by',
              style: TextStyle(
                fontSize: 12.0,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              ' Abdul Rafay',
              style: TextStyle(
                fontSize: 13.0,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            Text(
              ' using Flutter',
              style: TextStyle(
                fontSize: 12.0,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
