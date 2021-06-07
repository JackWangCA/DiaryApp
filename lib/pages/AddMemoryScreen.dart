import 'package:diary/model/MemoryModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//This screen is shown when the user clicks on the add memory button on the mainscreen page

class AddMemoryPage extends StatefulWidget {
  final Memory memory;

  AddMemoryPage({this.memory});

  @override
  _AddMemoryPageState createState() => _AddMemoryPageState();
}

class _AddMemoryPageState extends State<AddMemoryPage> {
  String dropdownValue = 'One';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String memoryImagePath;
  String memoryName = '';
  String memoryDescription = '';
  String memoryCategory = '';
  double memoryLat = 0.00;
  double memoryLong = 0.00;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //the app bar that appears on the top of the screen
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Your Memory'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18.0),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            children: <Widget>[
              buildMemoryName(),
              SizedBox(height: 20),
              buildMemoryDescription(),
              SizedBox(height: 20),
              buildMemoryCategory(),
              SizedBox(height: 20),
              // buildMemoryLocation(),
              // SizedBox(height: 20),
            ],
          ),
        ),
      ),
      //the floating button at the bottom right ofthe screen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveMemory();
        },
        child: Icon(
          Icons.save,
        ),
      ),
    );
  }

  //the field that allows the user to type in the name of the memory
  Widget buildMemoryName() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'A name for your memory',
        labelText: 'Name',
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 18),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Memory Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        memoryName = value;
        print(Text(memoryName));
      },
    );
  }

  //the field that allows the user to type in the description of the memory
  buildMemoryDescription() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Some description for your memory',
        labelText: 'Description',
      ),
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 18),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Memory Description is Required';
        }

        return null;
      },
      onSaved: (String value) {
        memoryDescription = value;
        print(Text(memoryDescription));
      },
    );
  }

  //the field that allows the user to type in the category of the memory
  buildMemoryCategory() {
    return DropdownButtonFormField(
      onSaved: (String value) {
        memoryCategory = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Memory Category is Required';
        }

        return null;
      },
      value: dropdownValue,
      items: <String>['Study', 'Family', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  //the field that allows the user to get the location of the memory
  buildMemoryLocation() {}

  saveMemory() {
    print(Text('Save Memory function is called'));
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    print('form saved');
  }
}
