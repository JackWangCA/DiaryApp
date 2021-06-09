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
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.memory.memoryName,
        style: Theme.of(context).textTheme.headline1,
      )),
    );
  }
}
