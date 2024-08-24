import 'package:flutter/material.dart';
import 'mem.dart';
import 'cal.dart';
import 'woklog.dart';
import 'prog.dart';
import 'exer.dart';
import 'profile.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  // List of pages to display based on the bottom navigation bar selection
  final List<Widget> _pages = [
    HomePage(), // You need to create HomePage()
    ExerciseTutorialPage(), // You need to create WorkoutPage()
    ProfilePage(), // Assuming ProfilePage is already created
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Expanded(child: _buildContent(context)),
          _buildQuickActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey[900],
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 30.0, color: Colors.black),
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
                    color: Colors.grey[500],
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
          color: Colors.grey[800]!,
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
          color: Colors.grey[800]!,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WorkoutPlansPage()), // Ensure this page exists
            );
          },
        ),
        _buildSection(
          context,
          title: 'Calorie Summary',
          icon: Icons.restaurant_menu,
          color: Colors.grey[800]!,
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
          color: Colors.grey[800]!,
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
          color: Colors.grey[800]!,
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
          color: Colors.grey[800]!,
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
              color: Colors.black.withOpacity(0.3),
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
            style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      color: Colors.grey[900],
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogFoodPage()), // Ensure this page exists
              );
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
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.white,
              child: Icon(icon, color: Colors.black, size: 20.0),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
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

class WorkoutPlansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          'Workout Plans Page',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}

class LogFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          'Log Food Page',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
