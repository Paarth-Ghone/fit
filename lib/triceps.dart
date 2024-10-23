import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TricepsPage extends StatefulWidget {
  @override
  _TricepsPageState createState() => _TricepsPageState();
}

class _TricepsPageState extends State<TricepsPage> {
  List<dynamic> exercises = [];
  List<dynamic> filteredExercises = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  Future<void> _fetchExercises() async {
    final response = await http.get(Uri.parse('https://test-tuk7.onrender.com/exercises/triceps'));

    if (response.statusCode == 200) {
      print(response.body); // Log the raw response
      setState(() {
        exercises = json.decode(response.body);
        filteredExercises = exercises; // Initially, show all exercises
      });
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  void _filterExercises(String query) {
    setState(() {
      searchQuery = query;
      filteredExercises = exercises.where((exercise) {
        final titleLower = exercise['exerciseName'].toLowerCase(); // Use exerciseName here
        final searchLower = query.toLowerCase();
        print('Searching for: $searchLower, in: $titleLower'); // Debugging output
        return titleLower.contains(searchLower);
      }).toList();
    });
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Triceps Tutorial',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: _filterExercises,
                decoration: InputDecoration(
                  labelText: 'Search Exercises',
                  labelStyle: TextStyle(color: Colors.white), // Change label color
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Change border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent), // Change focused border color
                  ),
                  fillColor: Color(0xFF3D3D3D),
                  filled: true,
                ),
                style: TextStyle(color: Colors.white), // Change text color
              ),
            ),
            Expanded(
              child: _buildExerciseList(),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build the exercise list
  Widget _buildExerciseList() {
    if (filteredExercises.isEmpty) {
      return Center(child: Text('No exercises found', style: TextStyle(color: Colors.white)));
    }
    return Scrollbar(
      thumbVisibility: true, // Always show the scrollbar
      child: ListView.builder(
        itemCount: filteredExercises.length,
        itemBuilder: (context, index) {
          final exercise = filteredExercises[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 4.0,
            color: Colors.grey.withOpacity(0.9), // Semi-transparent background for cards
            child: ListTile(
              title: Text(
                exercise['exerciseName'], // Use exerciseName for title
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                _formatSteps(exercise['steps']), // Display steps
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigate to exercise details page (you can implement this later)
              },
            ),
          );
        },
      ),
    );
  }

  // Helper function to format steps into a single string
  String _formatSteps(List<dynamic> steps) {
    return steps.join('\n'); // Join steps with line breaks
  }
}
