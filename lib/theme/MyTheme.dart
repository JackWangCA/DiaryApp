import 'package:flutter/material.dart';

class MyTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFFF0F0F0),
    accentColor: Color(0xFFFFBD2E),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
          backgroundColor: Colors.black54),
      headline1: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        letterSpacing: 0.4,
        // fontFamily: 'SanFrancisco',
      ),
      headline6: TextStyle(
        fontSize: 36.0,
        fontStyle: FontStyle.italic,
        // fontFamily: 'SanFrancisco',
      ),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );
}
