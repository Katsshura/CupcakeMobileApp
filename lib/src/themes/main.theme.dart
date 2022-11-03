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
            color: Colors.black54,
            letterSpacing: 1.3),
        headline1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            color: Colors.black87,
        ),
        headline2: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w600,
          fontFamily: 'Roboto',
          color: Colors.white,
        ),
        headline3: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
          color: Colors.white,
        ),
        headline4: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
          color: Colors.black87,
        ),
        subtitle1: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto',
          color: Colors.black54,
        ),
      ),
    );
  }
}
