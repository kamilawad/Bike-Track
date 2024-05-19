import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobile_flutter/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LiveTrackingScreen extends StatefulWidget {
  @override
  _LiveTrackingScreenState createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  late IO.Socket _socket;
  Map<String, Marker> _markers = {};
  bool _isTracking = false;
  Location _locationService = Location();
  late AuthProvider _authProvider;
  List<LatLng> _userLocationHistory = [];
  double _totalDistanceTraveled = 0.0;
  DateTime? _startTrackingTime;

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _initSocket();
    _requestPermissions();
  }

  @override
  void dispose() {
    _stopLiveTracking();
    _socket.clearListeners();
    super.dispose();
  }

  void _initSocket() {
    print(_authProvider.user!.fullName);
    _socket = IO.io(
      'http://192.168.0.105:3000/live-tracking',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'userId': _authProvider.user!.id})
          .build(),
    );

    _socket.onConnect((data) {
      print('Connected to the server');
    });

    _socket.onDisconnect((data) {
      print('Disconnected from the server');
    });

    _socket.on('locationUpdate', (data) {
      final userId = data['userId'];
      final latitude = data['latitude'];
      final longitude = data['longitude'];
      final userName = data['userName'];

      setState(() {
        _markers[userId] = Marker(
          markerId: MarkerId(userId),
          position: LatLng(latitude, longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('User Information'),
                content: Text('Username: $userName'),
              ),
            );
          },
        );
      });
    });
  }

  void _stopLiveTracking() {

      _isTracking = false;
      _markers.clear();
      _userLocationHistory.clear();

    _socket.emit('stopTracking');
    _socket.disconnect();
  }

  void _requestPermissions() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    await _locationService.changeSettings(accuracy: LocationAccuracy.high);
  }

  void _startLiveTracking() {
    setState(() {
      _isTracking = true;
      _userLocationHistory.clear();
      _totalDistanceTraveled = 0.0;
      _startTrackingTime = null;
    });

    _socket.connect();
    _socket.emit('startTracking');
    _sendLocationUpdates();
  }

  void _sendLocationUpdates() {
    _locationService.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null &&
          currentLocation.accuracy != null &&
          currentLocation.accuracy! < 10.0) {
        final currentLatLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);

        if (_userLocationHistory.isNotEmpty) {
          final previousLatLng = _userLocationHistory.last;
          final distance = geo.Geolocator.distanceBetween(
            previousLatLng.latitude,
            previousLatLng.longitude,
            currentLatLng.latitude,
            currentLatLng.longitude,
          );

          if (distance > 10.0) {
            setState(() {
              final smoothedDistance = (_totalDistanceTraveled + distance) / 2;
              _totalDistanceTraveled = smoothedDistance;
              _userLocationHistory.add(currentLatLng);
            });

            _socket.emit('locationUpdate', {
              'latitude': currentLocation.latitude,
              'longitude': currentLocation.longitude,
              'userName': _authProvider.user!.fullName,
            });
          }
        } else {
          setState(() {
            _startTrackingTime = DateTime.now();
            _userLocationHistory.add(currentLatLng);
          });

          _socket.emit('locationUpdate', {
            'latitude': currentLocation.latitude,
            'longitude': currentLocation.longitude,
            'userName': _authProvider.user!.fullName,
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Tracking'),
      ),
      body: Stack(
        children: [
          GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(33.8547, 35.8623),
          zoom: 9.0,
        ),
        onMapCreated: (controller) => _mapController.complete(controller),
        markers: _markers.values.toSet(),
        polylines: _userLocationHistory.isNotEmpty
          ? {
              Polyline(
                polylineId: const PolylineId('userTrackingRoute'),
                points: _userLocationHistory,
                color: Colors.blue,
                width: 3,
              ),
            }
          : {},
      ),
      Positioned(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          child: _buildTrackingInfoWidget(),
        ),
      ],
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isTracking ? _stopLiveTracking : _startLiveTracking,
        child: Icon(_isTracking ? Icons.stop : Icons.location_on),
      ),
    );    
  }


  Widget _buildTrackingInfoWidget() {

    double _calculateAverageSpeed() {
      if (_userLocationHistory.isEmpty || _startTrackingTime == null) {
        return 0.0;
      }

      final movingTimeInSeconds = DateTime.now().difference(_startTrackingTime!).inSeconds;
      final movingDistanceInMeters = _totalDistanceTraveled;

      if (movingTimeInSeconds >= 5) {
        final averageSpeedKmh = (movingDistanceInMeters / movingTimeInSeconds) * 3.6;
        return averageSpeedKmh;
      } else {
        return 0.0;
      }
    }

    final averageSpeedKmh = _calculateAverageSpeed();

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Distance: ${(_totalDistanceTraveled / 1000).toStringAsFixed(2)} km',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Average Speed: ${averageSpeedKmh.toStringAsFixed(2)} km/h',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}


/*import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  late IO.Socket socket;
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  //static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
  LatLng? _currentP = null;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then((coordinates) => {
          generatePolyLineFromPoints(coordinates),
        }),
      },
    );
  }

  void initSocket() {
  socket = IO.io('http://192.168.0.105:3000/live-tracking', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  socket.connect();

  socket.onConnect((data) {
    print('Connected to the server');
    socket.emit('startTracking', {'userId': 'your_user_id'});
    _setupLocationListener();
  });

  socket.on('locationUpdate', (data) {
    final userId = data['userId'];
    final latitude = data['latitude'];
    final longitude = data['longitude'];
    updateUserLocation(userId, latitude, longitude);
  });
}
Map<String, Marker> markers = {};
void updateUserLocation(String userId, double latitude, double longitude) {
  setState(() {
    markers[userId] = Marker(
      markerId: MarkerId(userId),
      position: LatLng(latitude, longitude),
    );
  });
}

void _setupLocationListener() {
  _locationController.onLocationChanged.listen((LocationData currentLocation) {
    if (currentLocation.latitude != null && currentLocation.longitude != null) {
      setState(() {
        _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        _camerToPosition(_currentP!);
      });
      socket.emit('locationUpdate', {
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,
      });
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track your ride', style: TextStyle(color: Colors.black54)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      body: _currentP == null ? const Center(child:Text("Loading...")) : Center(
      child: GoogleMap(
        onMapCreated: ( (GoogleMapController controller) => _mapController.complete(controller)),
        initialCameraPosition: const CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("_currentLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: _currentP!,
          ),
        },
        polylines: Set<Polyline>.of(polylines.values),
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
        initSocket(); // Initialize the WebSocket connection
        _locationController.onLocationChanged.listen((LocationData currentLocation) {
          if (currentLocation.latitude != null && currentLocation.longitude != null) {
            setState(() {
              _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
              _camerToPosition(_currentP!);
            });
            socket.emit('locationUpdate', {
              'latitude': currentLocation.latitude,
              'longitude': currentLocation.longitude,
            });
          }
        });
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

  Future<void> _camerToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos, zoom: 13
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition)
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

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _camerToPosition(_currentP!);
          //print(_currentP);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates("", PointLatLng(33.8938, 35.5018), PointLatLng(34.1236, 35.6511), travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Color(0xFFF05206),
      points: polylineCoordinates,
      width: 8,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}*/