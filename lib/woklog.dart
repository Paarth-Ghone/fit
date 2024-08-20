import 'package:flutter/material.dart';

class WorkoutLoggingPage extends StatelessWidget {
  final List<String> exerciseOptions = ['Squat', 'Bench Press', 'Deadlift', 'Pull-up', 'Push-up'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Workout'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log Your Workout',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            _buildExerciseDropdown(),
            SizedBox(height: 10.0),
            _buildInputField('Sets', TextInputType.number),
            SizedBox(height: 10.0),
            _buildInputField('Reps', TextInputType.number),
            SizedBox(height: 10.0),
            _buildInputField('Weight (kg)', TextInputType.number),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle workout logging
              },
              child: Text('Log Workout'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                primary: Colors.green,
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseDropdown() {
    String selectedExercise = exerciseOptions[0];

    return DropdownButtonFormField<String>(
      value: selectedExercise,
      decoration: InputDecoration(
        labelText: 'Exercise',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: (value) {
        selectedExercise = value!;
      },
      items: exerciseOptions.map((exercise) {
        return DropdownMenuItem<String>(
          value: exercise,
          child: Text(exercise),
        );
      }).toList(),
    );
  }

  Widget _buildInputField(String label, TextInputType inputType) {
    return TextField(
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
