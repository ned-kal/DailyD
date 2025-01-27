import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboard extends StatelessWidget {
  Future<void> addDaysToMonth(String month, int days) async {
    final firestore = FirebaseFirestore.instance;

    try {
      // Ensure the month document exists before adding days
  //    await firestore.collection('writeups').doc(month).set({
   //     'monthInitialized': true, // Placeholder to signify initialization
    //  });

      // Add days to the month
      for (int day = 1; day <= days; day++) {
        await firestore
            .collection('writeups')
            .doc(month)
            .collection('days')
            .doc(day.toString())
            .set({
          'topic': '', // Placeholder for topic
          'bible': '', // Placeholder for bible reference
          'word': '', // Placeholder for word
          'prayerHeading': '', // Placeholder for prayer heading
          'prayerBody': '', // Placeholder for prayer body
        });
        print('Added Day $day for $month');
      }
      print('Successfully added $days days to $month.');
    } catch (e) {
      print('Error adding days to $month: $e');
    }
  }

  Future<void> setupFirestoreStructure(BuildContext context) async {
    const monthDays = {
      'January': 31,
      'February': 29, // Leap year
      'March': 31,
      'April': 30,
      'May': 31,
      'June': 30,
      'July': 31,
      'August': 31,
      'September': 30,
      'October': 31,
      'November': 30,
      'December': 31,
    };

    try {
      for (String month in monthDays.keys) {
        print('Starting setup for $month');
        await addDaysToMonth(month, monthDays[month]!);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Firestore setup complete!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during setup: $e')),
      );
    }
  }

  Future<void> clearFirestoreData(BuildContext context) async {
    final firestore = FirebaseFirestore.instance;

    try {
      final confirmation = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Clear Firestore Data'),
          content: const Text(
              'This action will delete all data in the "writeups" collection. Are you sure?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirm'),
            ),
          ],
        ),
      );

      if (confirmation == true) {
        final snapshot = await firestore.collection('writeups').get();
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Firestore data cleared!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error clearing data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () async {
                await setupFirestoreStructure(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 30, 129, 33),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Setup Firestore Structure',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await clearFirestoreData(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 19, 104, 173),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Clear Firestore Data',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
