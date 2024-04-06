import 'package:flutter/material.dart';
import 'package:rafay_portfolio/constants/widgets/text/textstyle.dart';

Widget buildStyledText(
    String text, double fontSize, FontWeight fontWeight, Color color) {
  return StyledText(
    text: text,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}
