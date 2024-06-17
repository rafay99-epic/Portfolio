import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  final String text;

  const CopyButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(text),
        IconButton(
          icon: Icon(Icons.copy, color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: text));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Copied to clipboard')),
            );
          },
        ),
      ],
    );
  }
}
