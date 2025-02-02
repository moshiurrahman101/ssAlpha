import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';
import 'screen/dashboard_screen.dart';
import 'screen/live_device_location.dart';
import 'screen/emergency_notifications_page.dart';
import 'screen/about_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ssAlpha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Start with the Splash Screen
      routes: {
        '/': (context) => SplashScreen(), // Splash Screen
        '/dashboard': (context) => DashboardScreen(), // Dashboard Screen
        '/live_location': (context) =>
            LiveDeviceLocation(), // Live Location Page
        '/emergency_notifications': (context) =>
            EmergencyNotificationsPage(), // Emergency Notifications Page
        '/about': (context) => AboutPage(),
      },
    );
  }
}
