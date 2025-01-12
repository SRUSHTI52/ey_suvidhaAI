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
            Icon(Icons.account_balance, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Suvidha AI',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
