import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData buildLightPrimary() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFFAE7A3D),
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        button: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
        overline: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
            color: Colors.black45),
        labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
            color: Colors.black54, letterSpacing: 1.3),
      ),
    );
  }
}
