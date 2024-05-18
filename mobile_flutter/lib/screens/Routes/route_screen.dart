import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_flutter/screens/Routes/location_service.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylinePoints = <LatLng>[];
  int _polylineIdCounter = 1;

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(33.8547, 35.8623),
    zoom: 7.0,
  );

  @override
  void initState() {
    super.initState();
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolyline(List<LatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;
    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 3,
        color: Colors.blue,
        points: points,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routes'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.0,
                    child: TextField(
                      controller: _originController,
                      decoration: InputDecoration(
                        hintText: 'Origin',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 48.0,
                    child: TextField(
                      controller: _destinationController,
                      decoration: InputDecoration(
                        hintText: 'Destination',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    onTap: () async {
                      var directions = await LocationService().getDirections(
                        _originController.text,
                        _destinationController.text,
                        );
                        if (directions.isNotEmpty) {
                          _goToPlace(directions);
                          _setPolyline(directions['polyline_decoded']);
                        } else {
                          print('No directions found');
                        }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Color(0xFFF05206),
                          width: 2.0,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search,
                            color: Color(0xFFF05206),
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            'Search',
                            style: TextStyle(
                              color: Color(0xFFF05206),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              polylines: _polylines,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (point) {
                setState(() {
                  polylinePoints.add(point);
                  _setPolyline(polylinePoints);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> directions) async {
    final GoogleMapController controller = await _controller.future;

    if (directions.containsKey('start_location') && directions['start_location'] != null) {
      final double lat = directions['start_location']['lat'];
      final double lng = directions['start_location']['lng'];

      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 12),
        ),
      );

      _setMarker(LatLng(lat, lng));
    }

    if (directions.containsKey('bounds_ne') && directions.containsKey('bounds_sw') && directions['bounds_ne'] != null && directions['bounds_sw'] != null) {
      final Map<String, dynamic> boundsNe = directions['bounds_ne'];
      final Map<String, dynamic> boundsSw = directions['bounds_sw'];

      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25,
        ),
      );
    }
  }
}