import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name = "John Doe";
  final String email = "john.doe@example.com";
  final String membershipStatus = "Active";
  final String profileImageUrl = "https://via.placeholder.com/150";

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
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),

              // Email
              Text(
                email,
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
                      color: membershipStatus == "Active" ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Edit Profile Button
              _buildGradientButton(
                onPressed: () {
                  // Navigate to edit profile page
                },
                icon: Icons.edit,
                label: "Edit Profile",
              ),

              Spacer(),

              // Log Out Button
              _buildGradientButton(
                onPressed: () {
                  // Log out action
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
