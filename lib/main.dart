//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_devotional_1/Screens/about_page.dart';
import 'package:daily_devotional_1/Screens/admin_dashboard.dart';
import 'package:daily_devotional_1/Screens/first_screen.dart';
import 'package:daily_devotional_1/Screens/giveDonation_page.dart';
import 'package:daily_devotional_1/Screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/devotional_screen.dart';
import 'screens/admin_page.dart';
import 'Screens/signup_screen.dart';
import 'Screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore.instance.settings = const Settings(
  persistenceEnabled: true,
);

//FirebaseAnalytics analytics = FirebaseAnalytics();


  // Clear Firestore cache on app start
  await FirebaseFirestore.instance.clearPersistence();
  runApp(
    DailyDevotionalApp());
}

class DailyDevotionalApp extends StatelessWidget {
  const DailyDevotionalApp({super.key});

  Future<bool> isFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTime') ?? true; // Default to true for first-time users
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isFirstTimeUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading screen while checking preferences
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          final isFirstTime = snapshot.data ?? true;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Daily Family Prayer Companion 2025',
            theme: ThemeData(
              primarySwatch: Colors.green,
              fontFamily: 'Fredoka',
            ),
            home: isFirstTime ? FirstScreen() : HomeScreen(),
            onGenerateRoute: (settings) {
              if (settings.name == '/devotional') {
                final args = settings.arguments as String; // Pass the selectedDate as an argument
                return MaterialPageRoute(
                  builder: (context) => DevotionalScreen(selectedDate: args),
                );
              }
              return null;
            },
            routes: {
              '/firstScreen': (context) => FirstScreen(),
              '/onboardingFlow': (context) => OnboardingFlow(),
              '/home': (context) => HomeScreen(),
              '/admin': (context) => AdminPage(),
              '/signup': (context) => SignupPage(),
              '/login': (context) => LoginPage(),
              '/adminDashboard': (context) => AdminDashboard(),
              '/about': (context) => AboutPage(),
              '/give': (context) => DonationPage(),
              '/devotional': (context) => DevotionalScreen(selectedDate: ''),
            },
          );
        }
      },
    );
  }
}
