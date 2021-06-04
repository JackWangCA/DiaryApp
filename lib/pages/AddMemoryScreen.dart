import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMemoryPage extends StatefulWidget {
  @override
  _AddMemoryPageState createState() => _AddMemoryPageState();
}

class _AddMemoryPageState extends State<AddMemoryPage> {
  String memoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Memory'),
      ),
    );
  }
}
