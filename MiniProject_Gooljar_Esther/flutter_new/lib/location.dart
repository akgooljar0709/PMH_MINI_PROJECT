import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class location extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<location> {
  List<Marker> myMarkers = [];

  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationDataTemp;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationDataTemp = await location.getLocation();
    setState(() {
      _locationData = _locationDataTemp;
      myMarkers.add(Marker(
        width: 30.0,
        height: 30.0,
        point: LatLng(_locationData!.latitude!, _locationData!.longitude!),
        builder: (ctx) => Container(
          child: Container(
            child: Icon(
              Icons.location_on,
              color: Colors.blueAccent,
              size: 40,
            ),
          ),
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: FlutterMap(
          options: MapOptions(
              center: _locationData == null
                  ? LatLng(-20.148810, 57.474905)
                  : LatLng(_locationData!.latitude!, _locationData!.longitude!),
              zoom: 10.0),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 30.0,
                  height: 30.0,
                  point: LatLng(-20.04664,  57.52878),
                  builder: (ctx) => GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: ctx,
                        builder: (BuildContext context) {
                          return Container(
                            height: 100,
                            child: Center(
                              child: Text('Flic-en-Flac'),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      child: Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                Marker(
                  width: 30.0,
                  height: 30.0,
                  point: LatLng(-20.283211, 57.362297),
                  builder: (ctx) => GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: ctx,
                        builder: (BuildContext context) {
                          return Container(
                            height: 100,
                            child: Center(
                              child: Text('Flic-en-Flac'),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      child: Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                Marker(
                  width: 30.0,
                  height: 30.0,
                  point: LatLng(-20.011539, 57.579750),
                  builder: (ctx) => GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: ctx,
                        builder: (BuildContext context) {
                          return Container(
                            height: 100,
                            child: Center(
                              child: Text('Grand baie'),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      child: Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),Marker(
                  width: 30.0,
                  height: 30.0,
                  point: LatLng(-19.996617, 57.651506),
                  builder: (ctx) => GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: ctx,
                        builder: (BuildContext context) {
                          return Container(
                            height: 100,
                            child: Center(
                              child: Text('Grand Gaube'),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      child: Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                Marker(
                  width: 30.0,
                  height: 30.0,
                  point: LatLng(-20.001635, 57.649273),
                  builder: (ctx) => GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: ctx,
                        builder: (BuildContext context) {
                          return Container(
                            height: 100,
                            child: Center(
                              child: Text('Celodyne'),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      child: Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                // Add more markers here with their own info windows
              ],
            ),


          ],
        ),
      ),
    );
  }
}
