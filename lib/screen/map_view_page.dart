import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewPage extends StatelessWidget {
  // Constructor to optionally accept a location
  final LatLng? initialLocation;

  // Default to a location if not provided (e.g., New York City)
  const MapViewPage({super.key, this.initialLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
        backgroundColor: Colors.blueAccent,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation ?? LatLng(40.7128, -74.0060), // Default: NYC
          zoom: 12,
        ),
      ),
    );
  }
}
