import 'package:flutter/material.dart';
import 'package:flutter_social_media/common/Widgets/drawer.dart';

class ProfileScreen extends StatelessWidget {
  // Sample user data
  final String profileImageUrl = 'https://picsum.photos/200';
  final String userName = 'John Doe';
  final String userBio = 'Flutter Developer | Tech Enthusiast | Coffee Lover';
  final List<String> userInterests = ['Programming', 'Design', 'Music', 'Travel'];



  @override
  Widget build(BuildContext context) {

    void _logout() {
      // Implement your logout logic here
      Navigator.pushReplacementNamed(context, '/login'); // Example navigation
    }

    return Scaffold(

      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: CustomDrawer(onLogout: _logout), // Use the custom drawer here

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
            ),
            SizedBox(height: 16),
            // User Name
            Center(
              child: Text(
                userName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            // User Bio
            Center(
              child: Text(
                userBio,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Interests Section
            Text(
              'Interests',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: userInterests.map((interest) {
                return Chip(
                  label: Text(interest),
                  backgroundColor: Colors.deepPurple.shade100,
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            // Edit Profile Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your edit profile functionality here
                },
                child: Text('Edit Profile'),
                style: ElevatedButton.styleFrom(

                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}