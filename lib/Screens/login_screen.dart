import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
        Navigator.pushReplacementNamed(context, '/admin');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60), // Space for the back button
                const Text(
                  'Admin Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Roboto_Condensed',
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 7, 95, 22),
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 7, 95, 22)),
                    hintText: 'Enter your email',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 7, 95, 22),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 7, 95, 22)),
                    hintText: 'Enter your password',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 7, 95, 22),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // White text color
                    backgroundColor: const Color.fromARGB(255, 7, 95, 22),
                    minimumSize: Size(size.width, 50), // Match text field size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: _login,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
          // Back Button at the top
          Positioned(
            top: 20,
            left: 16,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home'); // Navigate to home
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
