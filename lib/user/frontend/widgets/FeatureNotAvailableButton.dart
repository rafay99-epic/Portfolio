import 'package:flutter/material.dart';

class FeatureNotAvailableButton extends StatefulWidget {
  const FeatureNotAvailableButton({
    super.key,
    required this.titleBox,
    required this.description,
  });
  final String titleBox;
  final String description;

  @override
  State<FeatureNotAvailableButton> createState() =>
      _FeatureNotAvailableButtonState();
}

class _FeatureNotAvailableButtonState extends State<FeatureNotAvailableButton> {
  Text buildStyledText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: buildStyledText(widget.titleBox),
      content: buildStyledText(widget.description),
      actions: [
        TextButton(
          child: buildStyledText('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
