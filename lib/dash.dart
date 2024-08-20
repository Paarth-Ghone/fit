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
        title: Text('Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, [User Name]',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  DashboardCard(
                    title: 'Membership',
                    icon: Icons.card_membership,
                    color: Colors.orangeAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MembershipManagementPage()),
                      );

                    },
                  ),
                  DashboardCard(
                    title: 'Workout Plans',
                    icon: Icons.fitness_center,
                    color: Colors.greenAccent,
                    onTap: () {
                      // Navigate to Workout Plans page
                    },
                  ),
                  DashboardCard(
                    title: 'Calorie Summary',
                    icon: Icons.restaurant_menu,
                    color: Colors.redAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalorieTrackingPage()),
                      );
                      // Navigate to Calorie Summary page
                    },
                  ),
                  DashboardCard(
                    title: 'Progress Tracker',
                    icon: Icons.show_chart,
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProgressTrackingPage()),
                      );
                      // Navigate to Progress Tracker page
                    },
                  ),
                  DashboardCard(
                    title: 'exer',
                    icon: Icons.table_bar_rounded,
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExerciseTutorialPage()),
                      );
                      // Navigate to Progress Tracker page
                    },
                  ),
                  DashboardCard(
                    title: 'Profile',
                    icon: Icons.table_bar_rounded,
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                      // Navigate to Progress Tracker page
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ActionButton(
                    title: 'Log Workout',
                    icon: Icons.note_add,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WorkoutLoggingPage()),
                      );
                      // Navigate to Log Workout page
                    },
                  ),
                  ActionButton(
                    title: 'Log Food',
                    icon: Icons.fastfood,
                    onTap: () {
                      // Navigate to Log Food page
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  DashboardCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40.0,
                color: Colors.white,
              ),
              SizedBox(height: 10.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  ActionButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.blueAccent,
            child: Icon(
              icon,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
