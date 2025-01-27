import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool isNewUser = true;
  int tapCount = 0; // Tracks the number of taps on the image

  @override
  void initState() {
    super.initState();
    _checkIfNewUser();
  }

  Future<void> _checkIfNewUser() async {
    final prefs = await SharedPreferences.getInstance();
    final newUserStatus = prefs.getBool('isNewUser') ?? true; // Default to true

    if (mounted) {
      setState(() {
        isNewUser = newUserStatus;
      });
    }
  }

  Future<void> _navigateNext() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      if (isNewUser) {
        await prefs.setBool('isNewUser', false); // Mark as returning user
        Navigator.pushReplacementNamed(context, '/onboardingFlow');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  void _incrementTap() {
    setState(() {
      tapCount++;
      print('Image tap count: $tapCount'); // Debug log
    });
    if (tapCount == 7) {
      setState(() {
        tapCount = 0; // Reset the count
      });
      print('Navigating to admin page'); // Debug log
      Navigator.pushReplacementNamed(context, '/login'); // Navigate to admin
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Tap Detection
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: _incrementTap, // Count taps on the image
              child: Image.asset(
                'assets/images/Man_Bible.jpg',
                height: height * 0.58,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay for DAILY DEVOTIONAL FOR THE WHOLE FAMILY" text
          Positioned(
            top: 50, // Adjust the value for proper spacing
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'DAILY DEVOTIONAL FOR THE WHOLE FAMILY',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Content Overlay
          Positioned.fill(
            top: height * 0.582,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    'DAILY\nFAMILY PRAYER\nCOMPANION\n2025',
                    style: TextStyle(
                      fontSize: height * 0.040,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 7, 95, 22),
                      fontFamily: 'Roboto_Condensed',
                    ),
                  ),
                  SizedBox(height: 9),
                  Text(
                    'COMPILED BY :\nELDER SAMSON AMEH OPALUWAH.',
                    style: TextStyle(
                      fontSize: height * 0.014,
                      color: const Color.fromARGB(255, 7, 95, 22),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Fredoka',
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      width: size.width * 0.9,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 7, 95, 22),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _navigateNext, // Button performs navigation
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'Start Your Devotion',
                            style: TextStyle(
                              fontSize: height * 0.018,
                              color: Colors.white,
                              fontFamily: 'Fredoka',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
