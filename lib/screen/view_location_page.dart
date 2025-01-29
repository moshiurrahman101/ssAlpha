import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewLocationPage extends StatelessWidget {
  final String gpsLocation; // GPS Location passed from the notification

  const ViewLocationPage({super.key, required this.gpsLocation});

  @override
  Widget build(BuildContext context) {
    // Parse latitude and longitude from the GPS location string
    final coordinates = gpsLocation.split(', ');
    final double latitude = double.parse(coordinates[0]);
    final double longitude = double.parse(coordinates[1]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Location'),
        backgroundColor: Colors.redAccent,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude), // Focus on the given location
          zoom: 15, // Adjust zoom level for better visibility
        ),
        markers: {
          Marker(
            markerId: MarkerId('alertLocation'),
            position:
                LatLng(latitude, longitude), // Place the marker at the location
            infoWindow: InfoWindow(title: 'Emergency Location'),
          ),
        },
      ),
    );
  }
}
