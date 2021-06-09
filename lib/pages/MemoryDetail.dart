import 'dart:convert';
import 'package:diary/pages/MapScreen.dart';
import 'package:intl/intl.dart';
import 'package:diary/model/MemoryModel.dart';
import 'package:flutter/material.dart';

class MemoryDetailScreen extends StatefulWidget {
  final Memory memory;

  MemoryDetailScreen({this.memory});

  @override
  _MemoryDetailScreenState createState() => _MemoryDetailScreenState();
}

class _MemoryDetailScreenState extends State<MemoryDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _img64;
    if (widget.memory.memoryImage != null) {
      _img64 = base64Decode(widget.memory.memoryImage);
    } //this decodes the image into bytes}
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          widget.memory.memoryName,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(30.0),
                child: Image(
                  image: _img64 != null
                      ? MemoryImage(_img64)
                      : AssetImage('assets/no_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                    child: Text(
                      widget.memory.memoryDescription,
                      style: TextStyle(
                        fontSize: 15.0,
                        height: 1.5,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
                    child: Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                    child: Text(
                      widget.memory.memoryCategory,
                      style: TextStyle(
                        fontSize: 15.0,
                        height: 1.5,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
                    child: Text(
                      'Created Time',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                    child: Text(
                      DateFormat('yyyy-MM-dd – kk:mm')
                          .format(widget.memory.memoryCreatedTime),
                      style: TextStyle(
                        fontSize: 15.0,
                        height: 1.5,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
                    child: Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: Text('View Map Location'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return MapScreen(
                          memory: widget.memory,
                        );
                      }),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.delete),
        onPressed: () {
          Navigator.of(context).pop(widget.memory);
        },
      ),
    );
  }
}
