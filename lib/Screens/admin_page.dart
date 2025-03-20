import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _bibleController =
      TextEditingController(); // Bible Reference
  final TextEditingController _wordController =
      TextEditingController(); // Word of the Day
  final TextEditingController _prayerHeadingController =
      TextEditingController();
  final TextEditingController _prayerBodyController = TextEditingController();

  void _uploadWriteup() async {
    final month = _monthController.text.trim();
    final day = _dayController.text.trim();
    final topic = _topicController.text.trim();
    final bible = _bibleController.text.trim();
    final word = _wordController.text.trim();
    final prayerHeading = _prayerHeadingController.text.trim();
    final prayerBody = _prayerBodyController.text.trim();

    if (month.isNotEmpty &&
        day.isNotEmpty &&
        topic.isNotEmpty &&
        bible.isNotEmpty &&
        word.isNotEmpty &&
        prayerHeading.isNotEmpty &&
        prayerBody.isNotEmpty) {
      try {
        await _firestore
            .collection('writeups')
            .doc(month)
            .collection('days')
            .doc(day)
            .set({
          'topic': topic,
          'word': word,
          'bible': bible,
          'prayerHeading': prayerHeading,
          'prayerBody': prayerBody,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Writeup saved for $month, Day $day')),
        );

        // Clear inputs after successful upload
        _monthController.clear();
        _dayController.clear();
        _topicController.clear();
        _bibleController.clear();
        _wordController.clear();
        _prayerHeadingController.clear();
        _prayerBodyController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving writeup: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _navigateToDashboard() {
    Navigator.pushNamed(context, '/adminDashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard),
            onPressed: _navigateToDashboard,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _monthController,
                decoration: const InputDecoration(
                  labelText: 'Month',
                  hintText: 'e.g., January',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _dayController,
                decoration: const InputDecoration(
                  labelText: 'Day',
                  hintText: 'e.g., 1',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _topicController,
                decoration: const InputDecoration(
                  labelText: 'Topic of the Day',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller:
                    _bibleController, // Correct controller for Bible Reference
                decoration: const InputDecoration(
                  labelText: 'Bible Reference of the Day',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller:
                    _wordController, // Correct controller for Word of the Day
                decoration: const InputDecoration(
                  labelText: 'Word of the Day',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _prayerHeadingController,
                decoration: const InputDecoration(
                  labelText: 'Prayer Point Heading',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _prayerBodyController,
                decoration: const InputDecoration(
                  labelText: 'Prayer Point Body',
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _uploadWriteup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 38, 122, 41),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Upload Writeup',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
