import 'package:flutter/material.dart';

class WorkoutLoggingPage extends StatelessWidget {
  final List<String> exerciseOptions = ['Squat', 'Bench Press', 'Deadlift', 'Pull-up', 'Push-up'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Workout', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log Your Workout',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
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
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle workout logging
                },
                child: Text('Log Workout'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent,
                  onPrimary: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  textStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseDropdown() {
    String selectedExercise = exerciseOptions[0];

    return Card(
      elevation: 4.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedExercise,
        decoration: InputDecoration(
          labelText: 'Exercise',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: EdgeInsets.all(16.0),
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
      ),
    );
  }

  Widget _buildInputField(String label, TextInputType inputType) {
    return Card(
      elevation: 4.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }
}
