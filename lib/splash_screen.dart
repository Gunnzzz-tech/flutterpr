import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';// Import LoginPage

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // After 2 seconds, navigate to either LoginPage or HomePage based on authentication state
    @override
    Widget build(BuildContext context) {
      // After 2 seconds, navigate directly to the LoginPage
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushReplacementNamed(context, '/login');
      });

      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),  // Show a loading spinner while initializing
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),  // Show a loading spinner while initializing
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assests/yt_logo_rgb_dark.png', // Replace with your YouTube logo
              width: 200,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
