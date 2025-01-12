import 'package:flutter/material.dart';

class ApplicationFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Form'),
        backgroundColor: Color(0xFF6C63FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Form Fields
            TextField(
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Marital Status',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'State',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Income',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Submit button functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Form submitted!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6C63FF),
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
