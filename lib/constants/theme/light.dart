import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    // surface: Colors.grey.shade300,
    //Colors for user
    surface: Colors.black,
    primary: Colors.white.withOpacity(0.9),
    secondary: Colors.orange.shade600,
    tertiary: Colors.white,
    inversePrimary: const Color.fromRGBO(49, 164, 153, 1),
    outline: Colors.grey,
    //Colors for Admin Pannel
    onSurface: Colors.grey.shade300,
    primaryFixed: Colors.black,
  ),
);
