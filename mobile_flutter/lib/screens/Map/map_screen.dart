import 'package:location/location.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Location _locationController = new Location();

  static const LatLng _location = LatLng(33.854, 35.8623);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track your ride', style: TextStyle(color: Colors.black54)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      body: const Center(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _location,
            zoom: 12,
          )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/track');
          },
          backgroundColor: const Color(0xFFF05206),
          elevation: 0,
          highlightElevation: 0,
          child: const Text(
            'Start',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      ),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    }
    else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
}