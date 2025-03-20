import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 7, 95, 22), // Light green
                  Color.fromARGB(255, 7, 95, 22), // Darker green
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top Section with Back Button
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                      const Expanded(
                        child: Text(
                          "About Us",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Placeholder for symmetry
                    ],
                  ),
                  const SizedBox(height: 20),
                  // App Logo Section
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage("assets/images/bird3.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // App Name
                  const Text(
                    "DAILY FAMILY PRAYER\nCOMPANION 2025",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Roboto_Condensed",
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Tagline
                  const Text(
                    'COMPILED BY : ELDER SAMSON AMEH OPALUWAH.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 35),
                  // Content Section
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Who We Are",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF558B2F),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                            "Rooted in God’s Word and featuring contributions from dedicated servants of Christ, this devotional reflects a collective effort to address the spiritual needs of families. Its pages are filled with prayer points, Bible texts, and reflections designed to inspire spiritual maturity and harmony within the family unit. We pray that this guide strengthens your relationship with God and enriches your daily walk with Him.",
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Our Mission",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF558B2F),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "This devotional is thoughtfully compiled to enrich the prayer lives of families, offer guidance, inspiration, and a deeper connection with God.\nCreated as a support for family altars, it aims to \n"
                              "1. Foster daily prayer and scripture study.\n"
                              "2. Provide insights for spiritual growth and understanding.\n"
                              "3. Unite families in faith and worship",

                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Contact Us",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF558B2F),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Do you have questions, feedback, or want to get involved? Please reach out to us at:\n\n"
                              "📧 Email: bz-alil@outlook.com\n"
                              "🌐 Website: www.bz-alil.Kharizgroup.ng\n"
                              "📞 Phone: +2348057171954",
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                                color: Color.fromARGB(181, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
