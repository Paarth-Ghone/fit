import 'package:flutter/material.dart';
import 'profile.dart'; // Import your profile page if needed

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white70, // Light grey for headings
        ),),
        backgroundColor: Colors.grey[850],
        // This matches the theme of the app
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E2E2E), Color(0xFF121212)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account Settings',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white70, // Light grey for headings
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.person, color: Colors.grey[400]), // Lighter icon color
                title: Text('Profile', style: TextStyle(color: Colors.white70)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.lock, color: Colors.grey[400]),
                title: Text('Privacy', style: TextStyle(color: Colors.white70)),
                onTap: () {
                  // Add privacy settings action here
                },
              ),
              const SizedBox(height: 20),
              Text(
                'App Settings',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white70, // Light grey for headings
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.grey[400]),
                title: Text('Notifications', style: TextStyle(color: Colors.white70)),
                onTap: () {
                  // Add notification settings action here
                },
              ),
              ListTile(
                leading: Icon(Icons.language, color: Colors.grey[400]),
                title: Text('Language', style: TextStyle(color: Colors.white70)),
                onTap: () {
                  // Add language settings action here
                },
              ),
              // Add more settings options as needed
            ],
          ),
        ),
      ),
    );
  }
}
