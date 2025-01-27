import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DevotionalScreen extends StatefulWidget {
  final String selectedDate;

  const DevotionalScreen({super.key, required this.selectedDate});

  @override
  DevotionalScreenState createState() => DevotionalScreenState();
}

class DevotionalScreenState extends State<DevotionalScreen> {
  String _topic = '';
  String _bible = '';
  String _word = '';
  String _prayerHeading = '';
  String _prayerBody = '';
  bool _isMarkedAsRead = false;
  bool _isNewUser = true;
  bool _isLoading = true;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _loadDevotional();
    _checkMarkedAsReadOrNewUser();
  }

  Future<void> _loadDevotional() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final firestore = FirebaseFirestore.instance;
      List<String> dateParts = widget.selectedDate.split(' ');
      String month = dateParts[0];
      String day = dateParts[1];

      DocumentSnapshot monthSnapshot = await firestore
          .collection('writeups')
          .doc(month)
          .collection('days')
          .doc(day)
          .get();

      if (monthSnapshot.exists) {
        setState(() {
          _topic = monthSnapshot.get('topic') ?? 'No Topic';
          _bible = monthSnapshot.get('bible') ?? 'No Bible Verse';
          _word = monthSnapshot.get('word') ?? 'No Word';
          _prayerHeading =
              monthSnapshot.get('prayerHeading') ?? 'No Prayer Heading';
          _prayerBody = monthSnapshot.get('prayerBody') ?? 'No Prayer Body';
        });
      } else {
        setState(() {
          _topic = 'No Devotional Available';
          _bible = '';
          _word = 'No content found for the selected date.';
          _prayerHeading = '';
          _prayerBody = '';
        });
      }
    } catch (e) {
      setState(() {
        _topic = 'Error';
        _bible = '';
        _word = 'Failed to load devotional. Please try again later.';
        _prayerHeading = '';
        _prayerBody = '';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _checkMarkedAsReadOrNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasOpenedBefore = prefs.getBool('hasOpenedBefore') ?? false;

    if (!hasOpenedBefore) {
      await prefs.setBool('hasOpenedBefore', true);
      setState(() {
        _isNewUser = true;
      });
    } else {
      setState(() {
        _isNewUser = false;
        _isMarkedAsRead = prefs.getBool(widget.selectedDate) ?? false;
      });
    }
  }

  Future<void> _markAsRead() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.selectedDate, true);
    setState(() {
      _isMarkedAsRead = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Marked as read!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.22, // Set the desired opacity (0.0 to 1.0)
                    child: Image.asset(
                      'assets/images/bird4.jpg', // Update this path to your background image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    // Top image with back button overlay
                    Stack(
                      children: [
                        // Top image
                        Image.asset(
                          'assets/images/bird3.jpg', // Update this to your header image
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150, // Adjust height as needed
                        ),
                        // Back button overlay
                        Positioned(
                          top: 20, // Adjust vertical position
                          left: 10, // Adjust horizontal position
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context); // Navigate back to the previous screen
                            },
                          ),
                        ),
                      ],
                    ),
                    // Title with white background
                    Container(
                      width: double.infinity, // Full width
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.white.withOpacity(0.8), // Semi-transparent background
                      child: Text(
                        _topic,
                        style: const TextStyle(
                          fontSize: 26,
                          fontFamily: 'Roboto_Condensed',
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 7, 95, 22),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Space between title and content
                    // Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                child: Text(
                                  _bible,
                                  maxLines: _isExpanded ? null : 4,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                    fontSize: 17.5,
                                    fontFamily: 'Fredoka',
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 7, 95, 22),
                                  ),
                                ),
                              ),
                              if (_bible.length > 150)
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isExpanded = !_isExpanded;
                                    });
                                  },
                                  child: Text(
                                    _isExpanded ? 'See Less' : 'See More',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 16),
                              Text(
                                _word,
                                style: const TextStyle(
                                    fontSize: 17.5, color: Colors.black87),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                _prayerHeading,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _prayerBody,
                                style: const TextStyle(
                                    fontSize: 16.5, color: Colors.black87),
                              ),
                              const SizedBox(height: 20),
                              if (!_isNewUser && !_isMarkedAsRead)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 20, 146, 41)),
                                  onPressed: _markAsRead,
                                  child: const Text(
                                    'Mark as Done',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              else if (_isMarkedAsRead)
                                const Text(
                                  'You have completed this day\'s devotional.',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
