import 'package:diary/pages/AddMemoryScreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memories'),
      ),
      body: null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return AddMemoryPage();
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
