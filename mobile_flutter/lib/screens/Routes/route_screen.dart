import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

class RouteScreen extends StatefulWidget {
  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylinePoints = [];
  Map<MarkerId, Marker> markers = {};
  LatLng? startPoint;

  @override
  void initState() {
    super.initState();
  }

  Future<List<LatLng>> getPolylinePoints(List<LatLng> points) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    for (int i = 0; i < points.length - 1; i++) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyB23mdww8kGOa4BnrL3higCEWp0H-KzkQo",
        PointLatLng(points[i].latitude, points[i].longitude),
        PointLatLng(points[i + 1].latitude, points[i + 1].longitude),
        travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      } else {
        print(result.errorMessage);
      }
    }

    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 4,
    );

    setState(() {
      polylines[id] = polyline;
      _addMarkers(polylineCoordinates.first, polylineCoordinates.last);
    });

    LatLngBounds bounds = _calculateBounds(polylineCoordinates);
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  LatLngBounds _calculateBounds(List<LatLng> coordinates) {
    double? minLat, minLong, maxLat, maxLong;
    for (LatLng coord in coordinates) {
      minLat = (minLat == null || coord.latitude < minLat)
          ? coord.latitude
          : minLat;
      minLong = (minLong == null || coord.longitude < minLong)
          ? coord.longitude
          : minLong;
      maxLat = (maxLat == null || coord.latitude > maxLat)
          ? coord.latitude
          : maxLat;
      maxLong = (maxLong == null || coord.longitude > maxLong)
          ? coord.longitude
          : maxLong;
    }
    return LatLngBounds(
      southwest: LatLng(minLat!, minLong!),
      northeast: LatLng(maxLat!, maxLong!),
    );
  }

  void resetRoute() {
    setState(() {
      polylines.clear();
      polylinePoints.clear();
      markers.clear();
      startPoint = null;
    });
  }

  void _addMarkers(LatLng start, LatLng end) {
    markers.clear();

    final MarkerId startMarkerId = MarkerId('start');
    final Marker startMarker = Marker(
      markerId: startMarkerId,
      position: start,
      infoWindow: InfoWindow(title: 'Start'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen,
      ),
    );

    final MarkerId endMarkerId = MarkerId('end');
    final Marker endMarker = Marker(
      markerId: endMarkerId,
      position: end,
      infoWindow: InfoWindow(title: 'End'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
    );

    markers[startMarkerId] = startMarker;
    markers[endMarkerId] = endMarker;
    startPoint = start;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Map'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetRoute,
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(33.8938, 35.5018),
          zoom: 12.0,
        ),
        polylines: Set<Polyline>.of(polylines.values),
        markers: Set<Marker>.of(markers.values),
        onTap: (LatLng point) async {
          if (startPoint != null && _isNearStartPoint(point, startPoint!, 70)) {
            setState(() {
              polylinePoints.add(startPoint!);
            });
            List<LatLng> coordinates = await getPolylinePoints(polylinePoints);
            generatePolyLineFromPoints(coordinates);
          } else {
            setState(() {
              polylinePoints.add(point);
            });

            if (polylinePoints.length > 1) {
              List<LatLng> coordinates = await getPolylinePoints(polylinePoints);
              generatePolyLineFromPoints(coordinates);
            }
          }
        },
      ),
    );
  }

  bool _isNearStartPoint(LatLng point, LatLng startPoint, double radius) {
    double distance = Geolocator.distanceBetween(
      point.latitude,
      point.longitude,
      startPoint.latitude,
      startPoint.longitude,
    );
    return distance <= radius;
  }
}