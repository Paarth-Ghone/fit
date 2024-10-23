import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'dart:convert'; // For encoding data to JSON

class WorkoutLoggingPage extends StatefulWidget {
  @override
  _WorkoutLoggingPageState createState() => _WorkoutLoggingPageState();
}

class _WorkoutLoggingPageState extends State<WorkoutLoggingPage> {
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // Fetch the userId from SharedPreferences
  Future<String?> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId'); // Assuming you stored userId as 'userId'
  }

  // Function to log workout data to the database
  Future<void> _logWorkout() async {
    String? userId = await _getUserId();

    if (userId != null) {
      // Create a workout object
      final workoutData = {
        'userId': userId,
        'exercise': _exerciseController.text,
        'sets': _setsController.text,
        'reps': _repsController.text,
        'weight': _weightController.text,
      };

      // Send the workout data to your backend API
      final response = await http.post(
        Uri.parse('https://test-tuk7.onrender.com/add-workout'), // Replace with your API endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(workoutData),
      );

      if (response.statusCode == 201) {
        // Successfully logged workout
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Workout logged successfully!')),
        );

        // Clear input fields after logging
        _exerciseController.clear();
        _setsController.clear();
        _repsController.clear();
        _weightController.clear();
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to log workout.')),
        );
      }
    } else {
      // User ID not found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in.')),
      );
    }
  }

  // Function to view logged workouts
  void _viewWorkouts() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewWorkoutDataPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'img/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.0),
                Text(
                  'Log Your Workout',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0),
                _buildExerciseInputField(),
                SizedBox(height: 20.0),
                _buildInputField('Sets', TextInputType.number, _setsController),
                SizedBox(height: 10.0),
                _buildInputField('Reps', TextInputType.number, _repsController),
                SizedBox(height: 10.0),
                _buildInputField('Weight (kg)', TextInputType.number, _weightController),
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildLogWorkoutButton(),
                ),
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildViewWorkoutsButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseInputField() {
    return Card(
      elevation: 4.0,
      color: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        controller: _exerciseController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: 'Exercise',
          labelStyle: TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.all(16.0),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextInputType inputType, TextEditingController controller) {
    return Card(
      elevation: 4.0,
      color: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.all(16.0),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildLogWorkoutButton() {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [Color(0xFF00FFCB), Color(0xFF008CFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(12.0),
    ),
    child: ElevatedButton(
    onPressed: _logWorkout, // Call the log workout function
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    ),
    padding: EdgeInsets.symmetric(vertical: 14.0),
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

  Widget _buildViewWorkoutsButton() {
    return ElevatedButton(
      onPressed: _viewWorkouts,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      ),
      child: Text(
        'View Workouts',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ViewWorkoutDataPage extends StatefulWidget {
  @override
  _ViewWorkoutDataPageState createState() => _ViewWorkoutDataPageState();
}

class _ViewWorkoutDataPageState extends State<ViewWorkoutDataPage> {
  DateTime? selectedDate;
  List<dynamic> workouts = [];

  Future<String?> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId'); // Assuming you stored userId as 'userId'
  }

  Future<void> _fetchWorkouts() async {
    String? userId = await _getUserId();
    if (userId != null && selectedDate != null) {
      String formattedDate = "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";

      final response = await http.get(
        Uri.parse('https://test-tuk7.onrender.com/get-workouts/$userId/$formattedDate'), // Replace with your API endpoint
      );

      if (response.statusCode == 200) {
        setState(() {
          workouts = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch workouts.')),
        );
      }
    }
  }

  Future<void> _deleteWorkout(String workoutId) async {
    String? userId = await _getUserId();
    if (userId != null) {
      final response = await http.delete(
        Uri.parse('https://test-tuk7.onrender.com/delete-workout/$userId/$workoutId'), // Replace with your API endpoint
      );

      if (response.statusCode == 200) {
        // Successfully deleted
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Workout deleted successfully!')),
        );
        // Fetch workouts again to update the list
        _fetchWorkouts();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete workout.')),
        );
      }
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Workouts',style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ), ),
        backgroundColor: Color(0xFF2E2E2E), // Dark color for app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E2E2E), Color(0xFF121212)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Date:',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4CAF50), // Green color for button
              ),
              child: Text(
                selectedDate == null ? 'Select Date' : "${selectedDate!.toLocal()}".split(' ')[0],
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _fetchWorkouts,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2196F3), // Blue color for button
              ),
              child: Text(
                'Fetch Workouts',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 10.0),
                    elevation: 4.0,
                    color: Colors.white.withOpacity(0.9), // Semi-transparent background for cards
                    child: ListTile(
                      title: Text(
                        workouts[index]['exercise'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Sets: ${workouts[index]['sets']}, Reps: ${workouts[index]['reps']}, Weight: ${workouts[index]['weight']} kg',
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteWorkout(workouts[index]['_id']), // Call delete function
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

