import 'package:flutter/material.dart';
import 'devotional_screen.dart';
import 'package:daily_devotional_1/Widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  final List<String> months = [
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER',
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
              color: const Color.fromARGB(255, 7, 95, 22), fontSize: 20.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 7, 95, 22)),
      ),
      drawer: SideMenu(),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bird4.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Overlay for darker shade on top of the image
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.48), // Semi-transparent overlay
            ),
          ),
          // Main content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 27, right: 27, top: 28, bottom: 1.0),
              child: Column(
                children: [
                  // Underlined title
                  Text(
                    'DAILY FAMILY PRAYER\nCOMPANION 2025',
                    style: TextStyle(
                      fontFamily: 'Roboto_Condensed',
                      fontSize: 19.0,
                      color: Colors.white,
                      letterSpacing: 1.1, // Adjust letter spacing here
                      decoration: TextDecoration.underline, // Add underline
                      decorationColor: Colors.white, // Ensure underline is white
                      decorationThickness: 1.0, // Adjust thickness
                      shadows: [
                        Shadow(
                          blurRadius: 0.5,
                          color: Colors.black.withOpacity(0.12),
                          offset: Offset(2, 2),
                        ),
                      ],
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center, // Center-align the text
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: months.asMap().entries.map((entry) {
                          int index = entry.key;
                          String month = entry.value;

                          // Get the number of days for each month
                          int daysInMonth = getDaysInMonth(index);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 28),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 1.8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(26),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      month,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Roboto_Condensed',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 18),
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5, // 5 buttons in a row
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 1,
                                      ),
                                      itemCount: daysInMonth,
                                      itemBuilder: (context, dayIndex) {
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 255, 255),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            // Format the month name to proper capitalization
                                            String formattedMonth = month[0].toUpperCase() +
                                                month.substring(1).toLowerCase();
                                            print(
                                                'Navigating to DevotionalScreen with selectedDate: $formattedMonth ${dayIndex + 1}');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DevotionalScreen(
                                                  selectedDate:
                                                      '$formattedMonth ${dayIndex + 1}',
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${dayIndex + 1}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: const Color.fromARGB(
                                                    255, 5, 104, 29),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
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

  int getDaysInMonth(int monthIndex) {
    if (monthIndex == 1) { // February
      int year = DateTime.now().year; // Get the current year
      if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return 29; // Leap year
      }
      return 28;
    }
    if ([3, 5, 8, 10].contains(monthIndex)) { // April, June, September, November
      return 30;
    }
    return 31;
  }
}
