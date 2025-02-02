import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'live_device_location.dart';

class EmergencyNotificationsPage extends StatefulWidget {
  const EmergencyNotificationsPage({super.key});

  @override
  _EmergencyNotificationsPageState createState() =>
      _EmergencyNotificationsPageState();
}

class _EmergencyNotificationsPageState
    extends State<EmergencyNotificationsPage> {
  final DatabaseReference _alertsRef =
      FirebaseDatabase.instance.ref('alerts'); // Firebase Reference
  final List<Map<String, dynamic>> _alertsList = []; // Stores fetched alerts
  late FlutterLocalNotificationsPlugin _localNotifications;

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
    _initializeLocalNotifications();
    _listenForAlerts(); // Listen for new alerts in Firebase
  }

  // 🔔 Initialize Firebase Cloud Messaging
  void _setupFirebaseMessaging() {
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showNotification(message.notification!.title ?? "Emergency Alert",
            message.notification!.body ?? "Check the app for details.");
      }
    });
  }

  // 🔔 Initialize Local Notifications
  void _initializeLocalNotifications() {
    _localNotifications = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    _localNotifications.initialize(settings);
  }

  // 🔔 Show Local Push Notification
  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'emergency_channel',
      'Emergency Alerts',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      0, // Notification ID
      title,
      body,
      notificationDetails,
    );
  }

  // 🔥 Listen for new Emergency Alerts from Firebase
  void _listenForAlerts() async {
    _alertsRef.onChildAdded.listen((event) async {
      // ✅ Use async
      final data = event.snapshot.value as Map?;
      if (data != null && data['Alert_Type'] == 'Emergency') {
        final alert = {
          'id': event.snapshot.key,
          'Alert_Type': data['Alert_Type'],
          'GPS_Location': data['GPS_Location'],
          'Timestamp': data['Timestamp'],
          'User_ID': data['User_ID'],
        };

        // ✅ Update UI on main thread
        setState(() {
          _alertsList.insert(0, alert);
        });

        // ✅ Use Future.delayed to avoid UI freeze
        Future.delayed(Duration(milliseconds: 500), () {
          _showNotification("🚨 Emergency Alert!", "New emergency reported.");
        });
      }
    });
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
                    leading: Icon(Icons.warning, color: Colors.red),
                    title: Text(
                      alert['Alert_Type'] ?? 'Unknown',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Timestamp: ${alert['Timestamp']}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // 🌍 Redirect to Live Location Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LiveDeviceLocation(),
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
