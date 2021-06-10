import 'dart:convert';

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
  List<Memory> memoryList =
      new List.empty(); //declare an empty list of memories
  SharedPreferences
      sharedPreferences; //declare a global variable sharePreferences

  @override
  void initState() {
    loadSharedPreferencesAndData(); //load the data from sharedPreferences to the memory list
    super.initState();
  }

  //
  //the GUI
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Memories',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          //the action button the is on the right of the app bar
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 20,
                0), //keep some distance from the right side of the screen
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(Icons.sort,
                    color: Theme.of(context).accentColor, size: 25.0),
                items: <String>['Alphabet', 'Time']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: Theme.of(context).textTheme.bodyText1),
                  );
                }).toList(),
                onChanged: (String value) {
                  if (value == 'Alphabet' && memoryList.length != 0) {
                    setState(() {
                      memoryList.sort((a, b) => a.memoryName
                          .toLowerCase()
                          .compareTo(b.memoryName
                              .toLowerCase())); //sort a list by their alphabetically order
                    });
                  } else if (value == 'Time' && memoryList.length != 0) {
                    setState(() {
                      memoryList.sort((b, a) => a.memoryCreatedTime.compareTo(b
                          .memoryCreatedTime)); //sort a list by their created time
                    });
                  }
                },
              ),
            ),
          )
        ],
      ),
      body: memoryList.isEmpty
          ? emptyList()
          : listView(), // if the list is empty, show empty view, otherwise, show listview
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            //push add memory page
            return AddMemoryPage();
          })).then((memory) {
            if (memory != null) {
              //if a memory is returned, add that memory
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
                memory:
                    memory), //pushes memoryDetail screen and passes the chosen memory
          ),
        ).then((memory) {
          //if a memory is being returned, it means we want to delete it
          if (memory != null) {
            setState(() {
              removeMemory(memory);
            });
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: 200.0,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              //shadow behind the image, un-comment if you want to enable it
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.circular(20.0),
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.black26,
              //       offset: Offset(5.0, .0),
              //       blurRadius: 10.0,
              //     )
              //   ],
              // ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      height: 230.0,
                      width: MediaQuery.of(context).size.width,
                      image: memory.memoryImage == null
                          ? AssetImage(
                              'assets/no_image.jpg') //if the user provides no image
                          : MemoryImage(
                              _img64), //creates image from the decoded bytes
                      fit: BoxFit
                          .cover, //makes sure that the image covers the entire container
                    ),
                  ),
                  Positioned(
                    left: 10.0,
                    bottom: 10.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.7), // 70% opacity
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                              child: Text(
                                memory.memoryName,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ],
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
    sharedPreferences = await SharedPreferences
        .getInstance(); //gets data from shared preferences
    loadData(); //load the data into the memory list, this process repeats every time the main page loads
  }
}
