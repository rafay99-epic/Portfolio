import 'package:flutter/material.dart';

class SnackBarWidget extends StatelessWidget {
  final String text;

  const SnackBarWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SnackBar(
      elevation: 10,
      duration: const Duration(seconds: 2),
      width: size.width * 0.9,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.surface,
          fontSize: 15,
        ),
      ),
    );
  }
}

SnackBar buildSnackBar(BuildContext context, String text) {
  final size = MediaQuery.of(context).size;
  return SnackBar(
    elevation: 10,
    duration: const Duration(seconds: 2),
    width: size.width * 0.9,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    behavior: SnackBarBehavior.floating,
    content: Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.surface,
        fontSize: 15,
      ),
    ),
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
}
