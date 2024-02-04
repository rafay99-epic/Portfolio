import "package:animated_text_kit/animated_text_kit.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class AnimatedTextBuilder extends StatelessWidget {
  final String text;
  final double size;
  final bool underline;
  const AnimatedTextBuilder({
    super.key,
    required this.text,
    required this.size,
    this.underline = false,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      softWrap: true,
      maxLines: 1,
      textAlign: TextAlign.left,
      style: GoogleFonts.roboto(
        fontSize: size,
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
        decoration: underline ? TextDecoration.underline : null,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(text),
        ],
      ),
    );
  }
}
