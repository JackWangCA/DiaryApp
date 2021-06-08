import 'dart:convert';
import 'dart:io';

import 'package:diary/model/MemoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

//This screen is shown when the user clicks on the add memory button on the mainscreen page

class AddMemoryPage extends StatefulWidget {
  final Memory memory;

  AddMemoryPage({this.memory});

  @override
  _AddMemoryPageState createState() => _AddMemoryPageState();
}

class _AddMemoryPageState extends State<AddMemoryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //declaring variables
  File _image;
  final picker = ImagePicker();
  String dropdownValue = 'Study';
  String memoryImage;
  String memoryName;
  String memoryDescription;
  String memoryCategory;
  DateTime memoryCreatedTime;
  double memoryLat = 0.00;
  double memoryLong = 0.00;

  //
  //the GUI
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              buildMemoryImage(),
              SizedBox(height: 20),
              buildMemoryName(),
              SizedBox(height: 20),
              buildMemoryDescription(),
              SizedBox(height: 20),
              buildMemoryCategory(),
              SizedBox(height: 20),
              buildMemoryLocation(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      //the floating button at the bottom right ofthe screen
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          saveMemory();
        },
        child: Icon(
          Icons.save,
        ),
      ),
    );
  }

  Widget buildMemoryImage() {
    if (memoryImage != null) {
      final image = FileImage(File(memoryImage));
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _image,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Theme.of(context).primaryColor,
            child: Text(
              'Change Image',
            ),
            onPressed: getImageFromLibrary,
          )
        ],
      );
    } else {
      return ElevatedButton(
          onPressed: getImageFromLibrary,
          child: Icon(
            Icons.add_a_photo,
          ));
    }
  }

  //the field that allows the user to type in the name of the memory
  Widget buildMemoryName() {
    return TextFormField(
      inputFormatters: [
        BlacklistingTextInputFormatter(
          RegExp(
              r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
        ),
      ],
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
      inputFormatters: [
        BlacklistingTextInputFormatter(
          RegExp(
              r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
        ),
      ],
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
      decoration: InputDecoration(labelText: 'Category'),
      validator: (String value) {
        if (value == null) {
          return 'Memory Category is Required';
        }

        return null;
      },
      // value: 'Study',
      items: <String>['Study', 'Family', 'Friends', 'Vacation']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onSaved: (String value) {
        memoryCategory = value;
        print(Text(memoryCategory));
      },
      onChanged: (String value) {
        memoryCategory = value;
      },
    );
  }

  //the field that allows the user to get the location of the memory
  buildMemoryLocation() {
    return Column(
      // ignore: deprecated_member_use
      children: [
        RaisedButton(
          onPressed: () {
            getLocation();
            print('get location is called');
          },
          child: Icon(Icons.add_location),
        ),
        locationHintText(),
      ],
    );
  }

  Widget locationHintText() {
    if (memoryLat == 0.0 && memoryLong == 0.0) {
      return Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Text(
            'Please add a location by pressing the button above',
          ));
    } else {
      return Column(
        children: [
          Text('Latitude is ' + '$memoryLat'.toString()),
          Text('Longitude is ' + memoryLong.toString()),
        ],
      );
    }
  }

  //data managing methods

  Future getImageFromLibrary() async {
    var pickedFile;
    try {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    } catch (e) {}

    if (pickedFile != null) {
      var imageFile = File(pickedFile.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      String photoBase64 = base64Encode(imageBytes);
      print(photoBase64);

      setState(() {
        _image = File(pickedFile.path);
        memoryImage = photoBase64;
      });

      // Directory appDocDir = await getApplicationDocumentsDirectory();
      // final fileName = path.basename(pickedFile.path);
      // final savedImage =
      //     await File(pickedFile.path).copy('${appDocDir.path}/$fileName');
      // setState(() {
      //   _image = File(pickedFile.path);
      //   memoryImagePath = savedImage.path;
      // });
      // print(memoryImagePath);
    } else {
      return;
    }
  }

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var currenPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      memoryLat = currenPosition.latitude;
      memoryLong = currenPosition.longitude;
    });
    print(memoryLat);
    print(memoryLong);
  }

  saveMemory() {
    print(Text('Save Memory function is called'));
    DateTime now = DateTime.now();
    memoryCreatedTime = now;
    String convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString()}-${now.minute.toString()}";
    print(convertedDateTime);
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Memory currentMemory = new Memory(
      memoryImage: memoryImage,
      memoryCreatedTime: memoryCreatedTime,
      memoryName: memoryName,
      memoryDescription: memoryDescription,
      memoryCategory: memoryCategory,
      memoryLat: memoryLat,
      memoryLong: memoryLong,
    );
    // print(currentMemory.memoryImage);

    Navigator.of(context).pop(currentMemory);

    print('form saved');
  }
}
