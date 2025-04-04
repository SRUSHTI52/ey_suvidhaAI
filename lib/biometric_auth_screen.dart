import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'dashboard.dart';

class BiometricAuthScreen extends StatefulWidget {
  @override
  _BiometricAuthScreenState createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  String _status = "Not Authenticated";

  Future<void> _authenticate() async {
    try {
      bool canCheckBiometrics = await _auth.canCheckBiometrics;
      bool isAuthenticated = false;

      if (canCheckBiometrics) {
        isAuthenticated = await _auth.authenticate(
          localizedReason: 'Please authenticate to access SuvidhaAI',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
      }

      setState(() {
        _status = isAuthenticated ? "Authenticated Successfully" : "Failed to Authenticate";
      });

      if (isAuthenticated) {
        // Navigate to dashboard or secure screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(), // Make sure this is imported
          ),
        );
      }

    } catch (e) {
      setState(() {
        _status = "Error: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate(); // auto-trigger auth on screen open
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF14267C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fingerprint, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(_status, style: TextStyle(color: Colors.white)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
