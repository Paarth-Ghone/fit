import 'package:flutter/material.dart';
import 'chest.dart'; // Import your chest.dart file
// Import other body part pages
import 'back.dart';
import 'legs.dart';
import 'biceps.dart';
import 'triceps.dart';
import 'shoulders.dart';
import 'abs.dart';

class ExerciseTutorialPage extends StatefulWidget {
  @override
  _ExerciseTutorialPageState createState() => _ExerciseTutorialPageState();
}

class _ExerciseTutorialPageState extends State<ExerciseTutorialPage> {
  // Navigate to respective page
  void _navigateToBodyPartPage(String bodyPart) {
    Widget page;
    switch (bodyPart) {
      case 'Chest':
        page = ChestPage(); // Navigate to the Chest page
        break;
      case 'Back':
        page = BackPage(); // Navigate to the Back page
        break;
      case 'Legs':
        page = LegsPage(); // Navigate to the Legs page
        break;
      case 'Biceps':
        page = BicepsPage(); // Navigate to the Biceps page
        break;
      case 'Triceps':
        page = TricepsPage(); // Navigate to the Triceps page
        break;
      case 'Shoulders':
        page = ShouldersPage(); // Navigate to the Shoulders page
        break;
      case 'Abs':
        page = AbsPage(); // Navigate to the Abs page
        break;
      default:
        return; // Do nothing if the body part is not recognized
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exercise Tutorials',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF2E2E2E), // Dark color to match the theme
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E2E2E), Color(0xFF121212)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildBodyPartTile('Chest'),
            _buildBodyPartTile('Back'),
            _buildBodyPartTile('Legs'),
            _buildBodyPartTile('Biceps'),
            _buildBodyPartTile('Triceps'),
            _buildBodyPartTile('Shoulders'),
            _buildBodyPartTile('Abs'),
          ],
        ),
      ),
    );
  }

  // Helper function to build body part tiles
  Widget _buildBodyPartTile(String bodyPart) {
    return GestureDetector(
      onTap: () => _navigateToBodyPartPage(bodyPart),
      child: Card(
        elevation: 4.0,
        color: Colors.black, // Semi-transparent white background for tiles
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the text
          children: [
            SizedBox(height: 8.0),
            Text(
              bodyPart,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color for visibility
              ),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
