import 'package:flutter/material.dart';

class ExerciseTutorialPage extends StatefulWidget {
  @override
  _ExerciseTutorialPageState createState() => _ExerciseTutorialPageState();
}

class _ExerciseTutorialPageState extends State<ExerciseTutorialPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> exercises = [
    {
      'name': 'Push-Up',
      'steps': '1. Start in a plank position.\n2. Lower your body until your chest nearly touches the floor.\n3. Push yourself back up to the starting position.',
      'safety': 'Keep your body straight and avoid sagging your hips.'
    },
    {
      'name': 'Squat',
      'steps': '1. Stand with feet shoulder-width apart.\n2. Lower your body as if sitting in a chair.\n3. Push through your heels to return to standing.',
      'safety': 'Keep your knees aligned with your toes and avoid rounding your back.'
    },
    {
      'name': 'Lunge',
      'steps': '1. Step forward with one leg.\n2. Lower your hips until both knees are bent at 90 degrees.\n3. Push through your front heel to return to standing.',
      'safety': 'Keep your front knee directly above your ankle and your back knee just above the ground.'
    },
  ];

  List<Map<String, String>> filteredExercises = [];

  @override
  void initState() {
    super.initState();
    filteredExercises = exercises;
  }

  void _filterExercises(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredExercises = exercises;
      });
    } else {
      setState(() {
        filteredExercises = exercises
            .where((exercise) =>
            exercise['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'img/background.png', // Update with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Content on top of background image
          Container(
            color: Colors.black.withOpacity(0.6), // Semi-transparent overlay
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.0), // Space for status bar
                Text(
                  'Exercise Tutorials',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for better contrast
                  ),
                ),
                SizedBox(height: 16.0),
                _buildSearchBar(),
                SizedBox(height: 20.0),
                Expanded(
                  child: _buildExerciseList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      style: TextStyle(color: Colors.white), // White text inside search bar
      decoration: InputDecoration(
        labelText: 'Search Exercises',
        labelStyle: TextStyle(color: Colors.white70), // White text for the label
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none, // No border
        ),
        prefixIcon: Icon(Icons.search, color: Colors.white70), // White icon
        filled: true,
        fillColor: Colors.white.withOpacity(0.2), // Semi-transparent fill color
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      ),
      onChanged: (query) {
        _filterExercises(query);
      },
    );
  }

  Widget _buildExerciseList() {
    return ListView.builder(
      itemCount: filteredExercises.length,
      itemBuilder: (context, index) {
        final exercise = filteredExercises[index];
        return Card(
          elevation: 5.0,
          color: Colors.black12.withOpacity(0.6), // Semi-transparent card background
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise['name']!,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for card title
                  ),
                ),
                SizedBox(height: 10),
                _buildDetailSection('Steps:', exercise['steps']!),
                SizedBox(height: 10),
                _buildDetailSection('Safety Tips:', exercise['safety']!),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text for section titles
          ),
        ),
        SizedBox(height: 5),
        Text(
          content,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white70, // Slightly faded white for content text
          ),
        ),
      ],
    );
  }
}
