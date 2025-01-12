import 'package:flutter/material.dart';
import 'dart:async';
import 'discover_schemes.dart'; // File for Discover Schemes screen
import 'document_upload_screen.dart'; // File for Document Upload screen
import 'profile.dart'; // File for Profile screen

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  // Titles for each tab
  final List<String> _titles = [
    'Dashboard',
    'Discover Schemes',
    'Upload Documents',
    'Profile',
  ];

  final List<Widget> _pages = [
    DashboardContent(), // Main dashboard content
    DiscoverSchemesScreen(), // Discover schemes
    DocumentUploadScreen(), // Upload documents
    ProfileScreen(), // Profile page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex], // Dynamic title based on the current tab
          style: TextStyle(color: Colors.white), // White title text for AppBar
        ),
        backgroundColor: Color(0xFF6C63FF),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color(0xFF6C63FF),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF6C63FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back, User!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Explore new schemes and track your progress seamlessly.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Statistics Section
            Text(
              'Your Statistics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAnimatedStatisticsCard(
                  title: 'Schemes Explored',
                  endValue: 15, // End value for animation
                  color: Colors.purple,
                ),
                _buildAnimatedStatisticsCard(
                  title: 'Documents Uploaded',
                  endValue: 8, // End value for animation
                  color: Colors.teal,
                ),
              ],
            ),
            SizedBox(height: 20),

            // Recommendations Section
            Text(
              'Recommended for You',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.star, color: Color(0xFF6C63FF)),
                title: Text('PM Kisan Scheme'),
                subtitle: Text('Financial aid for small farmers.'),
                trailing: Icon(Icons.arrow_forward, color: Colors.grey),
                onTap: () {
                  // Navigate to the scheme details
                },
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.star, color: Color(0xFF6C63FF)),
                title: Text('Ayushman Bharat'),
                subtitle: Text('Health insurance for families.'),
                trailing: Icon(Icons.arrow_forward, color: Colors.grey),
                onTap: () {
                  // Navigate to the scheme details
                },
              ),
            ),
            SizedBox(height: 20),

            // Tips Section
            Text(
              'Tips for You',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.lightbulb, color: Colors.orange),
                title: Text('Keep your documents updated!'),
                subtitle: Text(
                    'Upload the latest documents to get the best scheme recommendations.'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Widget: Animated Statistics Card
  Widget _buildAnimatedStatisticsCard({
    required String title,
    required int endValue,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: endValue),
                duration: Duration(seconds: 2),
                builder: (context, value, child) {
                  return Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
