import 'package:flutter/material.dart';
import 'Onboarding/onboarding_screen.dart'; // Import the correct file

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to OnboardingScreen after a 3-second delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Include your image here
            Image.asset(
              'assets/images/logo.png', // Path to your image
              width: 250, // Adjust size as needed
              height: 250,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
