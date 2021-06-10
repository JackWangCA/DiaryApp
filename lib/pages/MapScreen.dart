import 'dart:collection';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:diary/model/MemoryModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//API Key
//AIzaSyCr7eDEsbicqo7KFpBB2Nyt1UdURhn0DCw
//If you don't know what this is, probably don't touch it
//-Jack Wang

class MapScreen extends StatefulWidget {
  final Memory memory;

  MapScreen({this.memory});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController mapController;
  String titleText;
  LatLng currentMemoryLocation;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    titleText = widget.memory.memoryName;
    currentMemoryLocation =
        LatLng(widget.memory.memoryLat, widget.memory.memoryLong);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(titleText),
      ),
      body: Container(
        child: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: currentMemoryLocation, zoom: 13.0),
          onMapCreated: _onMapCreated,
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          markers: _markers,
        ),
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      _markers.add(Marker(
          markerId: MarkerId('0'),
          position: currentMemoryLocation,
          infoWindow: InfoWindow(
            title: titleText,
            snippet: DateFormat('yyyy-MM-dd – kk:mm')
                .format(widget.memory.memoryCreatedTime),
          )));
    });
  }
}
