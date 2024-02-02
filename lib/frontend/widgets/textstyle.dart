import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  final String text;
  final double fontSize;
  final List<String> boldWords;
  final bool underline;
  final bool bold;

  const StyledText({
    super.key,
    required this.text,
    required this.fontSize,
    this.boldWords = const [],
    this.underline = false,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    List<String> words = text.split(' ');
    return RichText(
      text: TextSpan(
        children: words.map((word) {
          if (boldWords.contains(word)) {
            return TextSpan(
              text: '$word ',
              style: GoogleFonts.roboto(
                decoration: underline ? TextDecoration.underline : null,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            );
          } else {
            return TextSpan(
              text: '$word ',
              style: GoogleFonts.roboto(
                decoration: underline ? TextDecoration.underline : null,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                fontSize: fontSize,
              ),
            );
          }
        }).toList(),
      ),
    );
  }
}
