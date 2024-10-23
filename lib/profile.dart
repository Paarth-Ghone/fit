import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'editprofile.dart';
import 'log.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  String email = "";
  String membershipStatus = "Inactive"; // Default to Inactive
  String profileImageUrl = "https://via.placeholder.com/150";
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndFetchProfile();
  }

  // Load the userId from SharedPreferences and fetch profile details
  Future<void> _loadUserIdAndFetchProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId'); // Fetch userId from SharedPreferences

    if (userId != null) {
      _fetchUserProfile(userId!);
    } else {
      // Handle case when userId is null
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID not found')),
      );
    }
  }

  // Fetch user profile and membership status
  Future<void> _fetchUserProfile(String userId) async {
    final response = await http.get(
      Uri.parse('https://test-tuk7.onrender.com/users/$userId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        name = data['name'];
        email = data['email'];
        membershipStatus = data['membershipStatus'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user profile')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              SizedBox(height: 20),

              // Name
              Text(
                name.isNotEmpty ? name : "Loading...",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),

              // Email
              Text(
                email.isNotEmpty ? email : "Loading...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 20),

              // Membership Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Membership Status',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    membershipStatus,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: membershipStatus == "Active"
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Edit Profile Button
              _buildGradientButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        currentName: name,
                        currentEmail: email,
                      ),
                    ),
                  );
                },
                icon: Icons.edit,
                label: "Edit Profile",
              ),

              Spacer(),

              // Log Out Button
              _buildGradientButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(

                      ),
                    ),
                  );// Log out action
                },
                icon: Icons.logout,
                label: "Log Out",
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    Color? backgroundColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundColor == null
            ? LinearGradient(
          colors: [Color(0xFF00FFCB), Color(0xFF008CFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          side: backgroundColor == null
              ? BorderSide.none
              : BorderSide(color: backgroundColor!, width: 2),
        ),
      ),
    );
  }
}
