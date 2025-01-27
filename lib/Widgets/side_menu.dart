import 'package:daily_devotional_1/Screens/first_screen.dart';
import 'package:flutter/material.dart';
import '../Screens/onboarding_screen.dart'; // Ensure the correct import for OnboardingFlow

class SideMenu extends StatelessWidget {
  const SideMenu({super.key}); // Added 'key' parameter

  @override
  Widget build(BuildContext context) {
    // Simulating admin check. Replace with actual logic, e.g., Firebase Auth or a shared state
    final bool isAdmin = true; // Set this dynamically based on logged-in user role

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 17, 100, 20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'DAILY\nFAMILY PRAYER\nCOMPANION\n2025',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Righteous',
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color.fromARGB(255, 17, 100, 20),
              ),
            title: const Text(
              'Home',
              style: TextStyle(
                color:Color.fromARGB(255, 17, 100, 20)
              ),
              ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          if (isAdmin)
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Color.fromARGB(255, 17, 100, 20),
                ),
              title: const Text(
                'Admin',
                style: TextStyle(color: Color.fromARGB(255, 17, 100, 20),),
                ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ListTile(
            leading: const Icon(
              Icons.book,
              color: Color.fromARGB(255, 17, 100, 20),
              ),
            title: const Text(
              'Onboarding',
              style: TextStyle(
                color: Color.fromARGB(255, 17, 100, 20),
              ),
              ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnboardingFlow(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.heat_pump_rounded,
              color: Color.fromARGB(255, 7, 95, 22),
              ),
            title: const Text(
              'Give/Donations',
              style: TextStyle(
                color: Color.fromARGB(255, 7, 95, 22),
              ),
              ),
            onTap: () {
              // Add logout functionality here
              Navigator.pushReplacementNamed(context, '/give');
            },
          ),
           ListTile(
            leading: const Icon(
              Icons.room_preferences_rounded,
              color: Color.fromARGB(255, 7, 95, 22),
              ),
            title: const Text(
              'About App',
              style: TextStyle(
                color: Color.fromARGB(255, 7, 95, 22),
              ),
              ),
            onTap: () {
              // Add logout functionality here
              Navigator.pushReplacementNamed(context, '/about');
            },
          ),
           ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Color.fromARGB(255, 207, 45, 4),
              ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Color.fromARGB(255, 207, 45, 4),
              ),
              ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FirstScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
