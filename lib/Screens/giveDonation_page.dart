import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  DonationPageState createState() => DonationPageState();
}

class DonationPageState extends State<DonationPage> {
  String _accountName = '';
  String _accountNumber = '';
  String _bankName = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDonationDetails();
  }

  Future<void> _loadDonationDetails() async {
    try {
      // Fetch donation details from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('donationDetails')
          .doc('details') // Use the specific document ID
          .get();

      if (snapshot.exists) {
        setState(() {
          _accountName = snapshot['accountName'] ?? 'N/A';
          _accountNumber = snapshot['accountNumber'] ?? 'N/A';
          _bankName = snapshot['bankName'] ?? 'N/A';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Donation details not found')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading donation details: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.4,
                image: AssetImage('assets/images/bird.jpg'), // Path to your image
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
          // Content Area
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Donation Details',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(224, 12, 10, 10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Account Name: $_accountName',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(224, 12, 10, 10),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Account Number: $_accountNumber',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(224, 12, 10, 10),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Bank Name: $_bankName',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(224, 12, 10, 10),
                              ),
                            ),
                            const SizedBox(height: 50), // Increased space before the button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 7, 95, 22),
                                foregroundColor: Colors.white, // White text color
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                              ),
                              onPressed: _loadDonationDetails, // Refresh details
                              child: const Text('Refresh Details'),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
          // Back Button
          Positioned(
            top: 50, // Adjust this to move the button further down
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromARGB(225, 0, 0, 0)),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home'); // Navigate back to the previous page
              },
            ),
          ),
        ],
      ),
    );
  }
}
