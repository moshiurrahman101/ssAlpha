import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class LiveDeviceLocation extends StatefulWidget {
  const LiveDeviceLocation({super.key});

  @override
  _LiveDeviceLocationState createState() => _LiveDeviceLocationState();
}

class _LiveDeviceLocationState extends State<LiveDeviceLocation> {
  final DatabaseReference _locationRef =
      FirebaseDatabase.instance.ref('device/device_location'); // Firebase Path

  GoogleMapController? _mapController;
  LatLng? _deviceLocation;
  Marker? _deviceMarker;
  final List<LatLng> _routeHistory = [];
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _listenToDeviceLocation(); // Start listening to Firebase
  }

  // Listen for real-time location updates from Firebase
  void _listenToDeviceLocation() {
    _locationRef.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        double latitude = double.parse(data['latitude'].toString());
        double longitude = double.parse(data['longitude'].toString());
        LatLng newLocation = LatLng(latitude, longitude);

        setState(() {
          _deviceLocation = newLocation;
          _routeHistory.add(newLocation);

          // Update marker for the device's current location
          _deviceMarker = Marker(
            markerId: MarkerId('deviceLocation'),
            position: newLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(title: "Device Current Location"),
          );

          // Draw route history (Polyline)
          _polylines.add(Polyline(
            polylineId: PolylineId("route"),
            points: _routeHistory,
            color: Colors.blue,
            width: 4,
          ));

          // Move the camera to the updated device location
          _mapController?.animateCamera(CameraUpdate.newLatLng(newLocation));
        });
      }
    });
  }

  // Clear the route history from the map
  void _clearRouteHistory() {
    setState(() {
      _routeHistory.clear();
      _polylines.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Device Location'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: 'Clear Route History',
            onPressed: _clearRouteHistory,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _deviceLocation ?? LatLng(0.0, 0.0), // Default to (0,0) if unknown
          zoom: 15,
        ),
        markers: _deviceMarker != null ? {_deviceMarker!} : {},
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
