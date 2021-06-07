import 'dart:convert';

import 'package:diary/model/MemoryModel.dart';
import 'package:diary/pages/AddMemoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreenPage extends StatefulWidget {
  @override
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  // ignore: deprecated_member_use
  List<Memory> memoryList = new List<Memory>();
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memories'),
      ),
      body: memoryList.isEmpty ? emptyList() : listView(),
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

  void loadData() {
    List<String> listString = sharedPreferences.getStringList('memoryList');
    if (listString != null) {
      memoryList = listString
          .map((memory) => Memory.fromMap(json.decode(memory)))
          .toList();
      setState(() {});
    }
  }

  void saveData() {
    List<String> stringList =
        memoryList.map((memory) => json.encode(memory.toMap())).toList();
    sharedPreferences.setStringList('memoryList', stringList);
  }

  Widget emptyList() {
    return Center(
      child: Text('No Memories Yet'),
    );
  }

  Widget listView() {
    return ListView.builder(
      itemCount: memoryList.length,
      itemBuilder: (BuildContext context, int index) {
        return buildItem(memoryList[index], index);
      },
    );
  }

  Widget buildItem(Memory memory, int index) {}
}