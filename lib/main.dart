import 'package:diary/pages/MainScreen.dart';
import 'package:diary/theme/MyTheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diary App',
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme,
      home: MainScreen(),
    );
  }
}
