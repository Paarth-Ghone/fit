import 'package:flutter/material.dart';
import 'adhome.dart';
class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AdminHomePage(),
    /*UserManagementPage(),
    WorkoutPlansPage(),
    NotificationsPage(),
    ProgressTrackingPage(),
    TrainerManagementPage(),*/
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
        title: Text('Admin Dashboard'),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                selectedIcon: Icon(Icons.dashboard_outlined),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                selectedIcon: Icon(Icons.people_outline),
                label: Text('Users'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.fitness_center),
                selectedIcon: Icon(Icons.fitness_center_outlined),
                label: Text('Workout Plans'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notifications),
                selectedIcon: Icon(Icons.notifications_outlined),
                label: Text('Notifications'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.assessment),
                selectedIcon: Icon(Icons.assessment_outlined),
                label: Text('Progress'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.supervised_user_circle),
                selectedIcon: Icon(Icons.supervised_user_circle_outlined),
                label: Text('Trainers'),
              ),
            ],
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
