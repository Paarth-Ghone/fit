import 'package:flutter/material.dart';
import 'mem.dart';
import 'cal.dart';
import 'woklog.dart';
import 'prog.dart';
import 'exer.dart';
import 'profile.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Expanded(child: _buildContent(context)),
            _buildQuickActions(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurpleAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 30.0, color: Colors.deepPurpleAccent),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, [User Name]',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _buildSection(
          context,
          title: 'Membership',
          icon: Icons.card_membership,
          color: Colors.purple[100]!,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MembershipManagementPage()),
            );
          },
        ),
        _buildSection(
          context,
          title: 'Workout Plans',
          icon: Icons.fitness_center,
          color: Colors.purple[200]!,
          onTap: () {
            // Navigate to Workout Plans page
          },
        ),
        _buildSection(
          context,
          title: 'Calorie Summary',
          icon: Icons.restaurant_menu,
          color: Colors.purple[300]!,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalorieTrackingPage()),
            );
          },
        ),
        _buildSection(
          context,
          title: 'Progress Tracker',
          icon: Icons.show_chart,
          color: Colors.purple[400]!,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProgressTrackingPage()),
            );
          },
        ),
        _buildSection(
          context,
          title: 'Exercise',
          icon: Icons.table_bar_rounded,
          color: Colors.purple[500]!,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExerciseTutorialPage()),
            );
          },
        ),
        _buildSection(
          context,
          title: 'Profile',
          icon: Icons.person,
          color: Colors.purple[600]!,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required IconData icon, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16.0),
          leading: Icon(icon, size: 40.0, color: Colors.white),
          title: Text(
            title,
            style: TextStyle(color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurpleAccent),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      color: Colors.deepPurple[100],
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(
            context,
            title: 'Log Workout',
            icon: Icons.note_add,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkoutLoggingPage()),
              );
            },
          ),
          _buildActionButton(
            context,
            title: 'Log Food',
            icon: Icons.fastfood,
            onTap: () {
              // Navigate to Log Food page
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.0, // Adjusted width
        height: 100.0, // Adjusted height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20.0, // Smaller radius
              backgroundColor: Colors.white,
              child: Icon(icon, color: Colors.deepPurpleAccent, size: 20.0), // Smaller icon size
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0, // Smaller font size
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
