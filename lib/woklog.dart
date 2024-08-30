import 'package:flutter/material.dart';

class WorkoutLoggingPage extends StatelessWidget {
  final List<String> exerciseOptions = ['Squat', 'Bench Press', 'Deadlift', 'Pull-up', 'Push-up'];

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
            color: Colors.black.withOpacity(0.6), // Slightly darker overlay for better contrast
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.0), // Space for status bar
                Text(
                  'Log Your Workout',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for better visibility
                  ),
                ),
                SizedBox(height: 20.0),
                _buildExerciseDropdown(),
                SizedBox(height: 20.0),
                _buildInputField('Sets', TextInputType.number),
                SizedBox(height: 10.0),
                _buildInputField('Reps', TextInputType.number),
                SizedBox(height: 10.0),
                _buildInputField('Weight (kg)', TextInputType.number),
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildLogWorkoutButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseDropdown() {
    String selectedExercise = exerciseOptions[0];

    return Card(
      elevation: 4.0,
      color: Colors.white.withOpacity(0.2), // Semi-transparent white for background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedExercise,
        style: TextStyle(color: Colors.white), // White text for dropdown items
        decoration: InputDecoration(
          labelText: 'Exercise',
          labelStyle: TextStyle(color: Colors.white70), // White label text
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none, // Remove border
          ),
          contentPadding: EdgeInsets.all(16.0),
          filled: true,
          fillColor: Colors.transparent, // No fill color to match the card background
        ),
        dropdownColor: Colors.black87, // Dropdown background color
        onChanged: (value) {
          selectedExercise = value!;
        },
        items: exerciseOptions.map((exercise) {
          return DropdownMenuItem<String>(
            value: exercise,
            child: Text(exercise),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInputField(String label, TextInputType inputType) {
    return Card(
      elevation: 4.0,
      color: Colors.white.withOpacity(0.2), // Semi-transparent white for background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        keyboardType: inputType,
        style: TextStyle(color: Colors.white), // White text for input field
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70), // White label text
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none, // Remove border
          ),
          contentPadding: EdgeInsets.all(16.0),
          filled: true,
          fillColor: Colors.transparent, // No fill color to match the card background
        ),
      ),
    );
  }

  Widget _buildLogWorkoutButton() {
    return Align(
      alignment: Alignment.centerRight,  // Align to the right
      child: Container(
        width: 150,  // Adjust width to make it shorter
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00FFCB), Color(0xFF008CFF)], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ElevatedButton(
          onPressed: () {
            // Handle workout logging
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,  // Use transparent to keep the gradient
            shadowColor: Colors.transparent,  // Remove button shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 14.0),  // Adjust padding
          ),
          child: Text(
            'Log Workout',
            style: TextStyle(
              fontSize: 18.0,

              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
