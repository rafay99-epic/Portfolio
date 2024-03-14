import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.black,
    secondary: Colors.orange.shade600,
    tertiary: Colors.white,
    // inversePrimary: Colors.orange.shade900,
    inversePrimary: const Color.fromRGBO(49, 164, 153, 1),
    outline: Colors.grey,
  ),
);
