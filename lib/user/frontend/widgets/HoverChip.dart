// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class HoverChip extends StatefulWidget {
  final String label;

  const HoverChip({super.key, required this.label});

  @override
  _HoverChipState createState() => _HoverChipState();
}

class _HoverChipState extends State<HoverChip> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isHovering
              ? Theme.of(context).colorScheme.inversePrimary
              : Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          widget.label,
          style: TextStyle(
            color: _isHovering
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
