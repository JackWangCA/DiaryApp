import 'package:flutter/material.dart';

class MyTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFFFFBD2E),
    accentColor: Color(0xFFF0F0F0),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        fontSize: 15.0,
        height: 1.5,
        letterSpacing: 1.1,
      ),
      headline1: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        letterSpacing: 0.4,
      ),
      headline2: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.2,
          color: Colors.black),
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
      ),
    ),
  );
}
