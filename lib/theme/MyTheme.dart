import 'package:flutter/material.dart';

class MyTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFFFFBD2E),
    accentColor: Color(0xFFF0F0F0),
    buttonColor: Colors.black,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        //text in the memory details page
        fontSize: 15.0,
        height: 1.5,
        letterSpacing: 0.2,
      ),
      headline1: TextStyle(
        //titles in the app bar
        fontSize: 25.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        letterSpacing: 0,
      ),
      headline2: TextStyle(
          //titles in the memory details page
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.3,
          color: Colors.black),
      headline3: TextStyle(
        // only for the memory titles on the main screen
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
      ),
    ),
  );
}
