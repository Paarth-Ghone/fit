import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For jsonEncode

class CalorieTrackingPage extends StatefulWidget {
  @override
  _CalorieTrackingPageState createState() => _CalorieTrackingPageState();
}

class _CalorieTrackingPageState extends State<CalorieTrackingPage> {
  final TextEditingController _calorieLimitController = TextEditingController();
  String? _userId; // Store userId here
  int dailyGoal = 2000; // Initialize with a default daily goal
  int caloriesConsumed = 0; // Track total calories consumed

  @override
  void initState() {
    super.initState();
    _loadUserId(); // Load userId from SharedPreferences
  }

  @override
  void dispose() {
    _calorieLimitController.dispose();
    super.dispose();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('userId'); // Retrieve userId
    });

    // Fetch calorie limit and consumed calories after loading userId
    await _fetchCurrentCalorieLimit();
    await _fetchCaloriesConsumed();
  }

  Future<void> _fetchCurrentCalorieLimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedCalorieLimit = prefs.getInt('dailyCalorieLimit');

    if (savedCalorieLimit != null) {
      setState(() {
        dailyGoal = savedCalorieLimit; // Load the calorie limit from SharedPreferences
      });
    } else if (_userId != null) {
      final url = Uri.parse('https://test-tuk7.onrender.com/calorie-limit/$_userId'); // Replace with your API URL
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          dailyGoal = responseData['dailyCalorieLimit']; // Update the daily goal
        });
        // Save the fetched calorie limit to SharedPreferences
        await prefs.setInt('dailyCalorieLimit', dailyGoal);
      } else {
        // Handle error
        print('Failed to fetch calorie limit');
      }
    }
  }

  Future<void> _fetchCaloriesConsumed() async {
    if (_userId != null) {
      final date = DateTime.now().toIso8601String().split('T')[0]; // Get today's date in YYYY-MM-DD format
      final url = Uri.parse('https://test-tuk7.onrender.com/daily-calorie-intake'); // Use your API URL
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': _userId,
          'date': date, // Pass today's date to the API
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          caloriesConsumed = responseData['totalCaloriesConsumed']; // Update calories consumed from the API response
        });
      } else {
        // Handle error
        print('Failed to fetch calories consumed: ${response.body}');
      }
    } else {
      print('User ID is null, cannot fetch calories consumed.');
    }
  }

  Future<void> _setCalorieLimit() async {
    final limit = _calorieLimitController.text;
    if (_userId != null) {
      // Prepare the API request
      final url = Uri.parse('https://test-tuk7.onrender.com/calorie-limit'); // Replace with your API URL
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': _userId,
          'calorieLimit': int.tryParse(limit), // Make sure it's an integer
        }),
      );

      if (response.statusCode == 200) {
        // Successfully set the calorie limit
        final responseData = jsonDecode(response.body);
        final updatedCalorieLimit = responseData['dailyCalorieLimit']; // Get the updated limit

        // Save the updated calorie limit to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('dailyCalorieLimit', updatedCalorieLimit);

        print('Daily Calorie Limit set to: $updatedCalorieLimit kcal');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Calorie limit set successfully!')),
        );

        // Update the daily goal counter
        setState(() {
          dailyGoal = updatedCalorieLimit; // Update the state variable that tracks the daily goal
        });
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to set calorie limit.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID not found.')),
      );
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
              'img/Designer.png', // Update with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Content on top of background image
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.4),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.0), // Space for status bar
                Text(
                  'Daily Calorie Summary',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                _buildCalorieSummary(),
                SizedBox(height: 24.0),
                Text(
                  'Set Daily Calorie Limit',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildCalorieLimitForm(),
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildGradientButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalorieSummary() {
    return Card(
      elevation: 6.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Total Calories Consumed:', '$caloriesConsumed kcal'),
            Divider(),
            _buildDetailRow('Daily Goal:', '$dailyGoal kcal'), // Use the dailyGoal variable here
            Divider(),
            // Other summary details can be added here
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16.0)),
        Text(value, style: TextStyle(fontSize: 16.0)),
      ],
    );
  }

  Widget _buildCalorieLimitForm() {
    return TextField(
      controller: _calorieLimitController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Enter your daily calorie limit',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildGradientButton() {
    return ElevatedButton(
      onPressed: _setCalorieLimit,
      child: Text('Set Calorie Limit'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
