import 'dart:convert';
import 'dart:io';

import 'package:diary/model/MemoryModel.dart';
import 'package:diary/pages/AddMemoryScreen.dart';
import 'package:diary/pages/MemoryDetail.dart';
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

  //
  //the GUI
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Memories',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(
                  Icons.sort,
                  color: Theme.of(context).accentColor,
                  size: 25.0,
                ),
                items: <String>['Alphabet', 'Time']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  // needs to implement
                },
              ),
            ),
          )
        ],
      ),
      body: memoryList.isEmpty ? emptyList() : listView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return AddMemoryPage();
            }),
          ).then((memory) {
            if (memory != null) {
              setState(() {
                addMemory(memory);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
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
        // print(memoryList[index].memoryImage);
        return buildItem(memoryList[index], index);
      },
    );
  }

  Widget buildItem(Memory memory, int index) {
    Memory memory = memoryList[index];
    var _img64;
    if (memory.memoryImage != null) {
      _img64 = base64Decode(memory.memoryImage);
    } //this decodes the image into bytes}

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MemoryDetailScreen(
              memory: memory,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: 200.0,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 2.0,
              child: Container(
                height: 120.0,
                width: 200.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0)
                  ]),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      height: 180.0,
                      width: MediaQuery.of(context).size.width,
                      image: memory.memoryImage == null
                          ? AssetImage(
                              'assets/no_image.jpg') //if the user provides no image
                          : MemoryImage(_img64),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 10.0,
                    bottom: 10.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          memory.memoryName,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //
  // the methods that manage the data
  //

  void saveData() {
    List<String> stringList =
        memoryList.map((memory) => json.encode(memory.toMap())).toList();
    sharedPreferences.setStringList('memoryList', stringList);
  }

  void addMemory(Memory memory) {
    // Insert an item into the top of our list, on index zero
    memoryList.insert(0, memory);
    saveData();
  }

  void removeMemory(Memory memory) {
    memoryList.remove(memory);
    saveData();
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

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }
}
