import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomPolylineScreen extends StatefulWidget {
  @override
  _CustomPolylineScreenState createState() => _CustomPolylineScreenState();
}

class _CustomPolylineScreenState extends State<CustomPolylineScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  List<LatLng> _userSelectedPositions = [];

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.4219, -122.0840),
    zoom: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Polyline'),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _mapController.complete(controller),
        gestureRecognizers: Set.from([
          Factory<PanGestureRecognizer>(_handlePanGesture),
          Factory<TapGestureRecognizer>(_handleTapGesture),
        ]),
        polylines: {
          Polyline(
            polylineId: PolylineId('user_polyline'),
            color: Colors.red,
            width: 5,
            points: _userSelectedPositions,
          ),
        },
        markers: _userSelectedPositions
            .map(
              (position) => Marker(
                markerId: MarkerId(position.toString()),
                position: position,
              ),
            )
            .toSet(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearPolyline,
        child: Icon(Icons.clear),
      ),
    );
  }

  void _clearPolyline() {
    setState(() {
      _userSelectedPositions.clear();
    });
  }

  PanGestureRecognizer _handlePanGesture() {
    return PanGestureRecognizer();
  }

  TapGestureRecognizer _handleTapGesture() {
    return TapGestureRecognizer()
      ..onTapUp = (TapUpDetails details) {
        final LatLng latLng = _getLatLngFromTapDetails(details) as LatLng;
        setState(() {
          _userSelectedPositions.add(latLng);
        });
      };
  }

  Future<LatLng> _getLatLngFromTapDetails(TapUpDetails details) {
    final renderBox = context.findRenderObject() as RenderBox;
    final globalPosition = renderBox.globalToLocal(details.globalPosition);
    return _mapController.future.then((controller) {
      return controller.getLatLng(globalPosition as ScreenCoordinate);
    });
  }
}