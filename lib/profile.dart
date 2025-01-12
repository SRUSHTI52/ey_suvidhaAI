import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Heading
          Text(
            'Your Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),

          // Profile Picture Section
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                      'assets/images/profile_pic.jpg'), // Add a placeholder image
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF14267C),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      onPressed: () {
                        // Future functionality for changing profile picture
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Change Profile Picture coming soon!')),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Profile Details Section
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildProfileRow(Icons.person, 'Name', 'John Doe'),
                  Divider(),
                  _buildProfileRow(Icons.email, 'Email', 'johndoe@example.com'),
                  Divider(),
                  _buildProfileRow(Icons.phone, 'Phone', '+91-9876543210'),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          // Edit Profile Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Add edit functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Edit Profile functionality coming soon!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF14267C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget to Build Each Profile Row
  Widget _buildProfileRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF14267C), size: 30),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
