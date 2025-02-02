import 'package:flutter/material.dart';
import 'emergency_notifications_page.dart';
import 'settings_page.dart';
import 'about_page.dart';
import 'live_device_location.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blueAccent, // Custom background color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Smart Sunglass Device Information Box
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.smart_toy,
                    size: 40,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Smart Sunglass Connected',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Battery: 80%, Signal: Strong',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Features Section
            Text(
              'Features',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // Feature List with Navigation
            Column(
              children: [
                FeatureItem(
                  icon: Icons.location_on,
                  title: 'Live Location Tracking',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LiveDeviceLocation()),
                  ),
                ),
                FeatureItem(
                  icon: Icons.warning_amber_rounded,
                  title: 'Emergency Notifications',
                  iconColor: Colors.redAccent,
                  backgroundColor: Colors.red[50],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmergencyNotificationsPage()),
                  ),
                ),
                FeatureItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  ),
                ),
                FeatureItem(
                  icon: Icons.info,
                  title: 'About',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Widget for Features
class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: iconColor ?? Colors.blueAccent,
            ),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
