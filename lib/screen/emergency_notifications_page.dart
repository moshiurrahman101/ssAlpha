import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'view_location_page.dart';

class EmergencyNotificationsPage extends StatefulWidget {
  const EmergencyNotificationsPage({super.key});

  @override
  _EmergencyNotificationsPageState createState() =>
      _EmergencyNotificationsPageState();
}

class _EmergencyNotificationsPageState
    extends State<EmergencyNotificationsPage> {
  final DatabaseReference _alertsRef =
      FirebaseDatabase.instance.ref('alerts'); // Reference to the alerts node
  final List<Map<String, dynamic>> _alertsList = []; // Stores fetched alerts

  @override
  void initState() {
    super.initState();
    _listenForAlerts(); // Listen for new alerts in Firebase
  }

  // Function to listen for new alerts in the Firebase Realtime Database
  void _listenForAlerts() {
    _alertsRef.onChildAdded.listen((event) {
      final data = event.snapshot.value as Map?;

      if (data != null) {
        // Only add alerts with type "Emergency"
        if (data['Alert_Type'] == 'Emergency') {
          final alert = {
            'id': event.snapshot.key,
            'Alert_Type': data['Alert_Type'],
            'GPS_Location': data['GPS_Location'],
            'Timestamp': data['Timestamp'],
            'User_ID': data['User_ID'],
          };

          setState(() {
            _alertsList.insert(
                0, alert); // Add the alert to the top of the list
          });

          // Show an in-app notification for the new alert
          _showNotification(alert);
        }
      }
    });
  }

  // Function to display an in-app notification for a new alert
  void _showNotification(Map<String, dynamic> alert) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'New Emergency Alert!',
          style: TextStyle(fontSize: 16),
        ),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'View',
          onPressed: () {
            // Navigate to the notification in the list
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Notifications'),
        backgroundColor: Colors.redAccent,
      ),
      body: _alertsList.isEmpty
          ? Center(
              child: Text(
                'No emergency alerts yet!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _alertsList.length,
              itemBuilder: (context, index) {
                final alert = _alertsList[index];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    title: Text(
                      alert['Alert_Type'] ?? 'Unknown',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Timestamp: ${alert['Timestamp']}'),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Navigate to the map page and pass the GPS location
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewLocationPage(
                              gpsLocation: alert[
                                  'GPS_Location'], // Pass the GPS location to the map page
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: Text('View Location'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
