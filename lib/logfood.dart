import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodIntakeLoggingPage extends StatefulWidget {
  @override
  _FoodIntakeLoggingPageState createState() => _FoodIntakeLoggingPageState();
}

class _FoodIntakeLoggingPageState extends State<FoodIntakeLoggingPage> {
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void dispose() {
    _foodController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _addFoodEntry() async {
    final String food = _foodController.text;
    final int? calories = int.tryParse(_caloriesController.text);
    final double? protein = double.tryParse(_proteinController.text);
    final int? quantity = int.tryParse(_quantityController.text);

    if (food.isNotEmpty && calories != null && calories > 0 && protein != null && quantity != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      if (userId != null) {
        try {
          final response = await http.post(
            Uri.parse('https://test-tuk7.onrender.com/add-food'),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "userId": userId,
              "food": food,
              "calories": calories,
              "protein": protein,
              "quantity": quantity,
            }),
          );

          if (response.statusCode == 201) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Food added successfully')),
            );

            // Clear the input fields
            _foodController.clear();
            _caloriesController.clear();
            _proteinController.clear();
            _quantityController.clear();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error adding food: ${response.body}')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not logged in')),
        );
      }
    }
  }

  void _viewFoodData() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewDataPage()),
    );
  }

  void _editFoodData() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditFoodEntriesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'img/fin.png', // Update with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Content on top of background image
          Container(
            color: Colors.black.withOpacity(0.4), // Semi-transparent overlay
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.0), // Space for status bar
                Text(
                  'Log Your Food Intake',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                _buildFoodLogForm(),
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      _buildGradientButton('Add Food', _addFoodEntry),
                      SizedBox(height: 10.0),
                      _buildGradientButton('View Data', _viewFoodData),
                      SizedBox(height: 10.0),
                      _buildGradientButton('Edit Entries', _editFoodData),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodLogForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _foodController,
          decoration: InputDecoration(
            labelText: 'Food Item',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          controller: _caloriesController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Calories (kcal)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          controller: _proteinController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Protein (g)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          controller: _quantityController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Quantity',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00FFCB), Color(0xFF008CFF)], // Gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ViewDataPage extends StatefulWidget {
  @override
  _ViewDataPageState createState() => _ViewDataPageState();
}

class _ViewDataPageState extends State<ViewDataPage> {
  DateTime? _selectedDate;
  List<Map<String, dynamic>> _foodEntries = [];

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });

      _fetchFoodEntriesForDate(pickedDate);
    }
  }

  Future<void> _fetchFoodEntriesForDate(DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null) {
      try {
        final response = await http.post(
          Uri.parse('https://test-tuk7.onrender.com/get-food-entries'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "userId": userId,
            "date": date.toIso8601String().split('T')[0],
          }),
        );

        if (response.statusCode == 200) {
          setState(() {
            _foodEntries = List<Map<String, dynamic>>.from(jsonDecode(response.body)['entries']);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error fetching data: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E2E2E), Color(0xFF121212)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              AppBar(
                title: Text('View Food Data' ,style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: Icon(Icons.calendar_today, color: Colors.white),
                    onPressed: _selectDate,
                  ),
                ],
              ),
              Expanded(
                child: _selectedDate == null
                    ? Center(child: Text('Select a date to view food entries', style: TextStyle(color: Colors.white)))
                    : ListView.builder(
                  itemCount: _foodEntries.length,
                  itemBuilder: (context, index) {
                    final entry = _foodEntries[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(entry['food'], style: TextStyle(color: Colors.white)),
                        subtitle: Text(
                          'Calories: ${entry['calories']}, Protein: ${entry['protein']}, Quantity: ${entry['quantity']}',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditFoodEntriesPage extends StatefulWidget {
  @override
  _EditFoodEntriesPageState createState() => _EditFoodEntriesPageState();
}

class _EditFoodEntriesPageState extends State<EditFoodEntriesPage> {
  DateTime? _selectedDate;
  List<Map<String, dynamic>> _foodEntries = [];

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });

      _fetchFoodEntriesForDate(pickedDate);
    }
  }

  Future<void> _fetchFoodEntriesForDate(DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null) {
      try {
        final response = await http.post(
          Uri.parse('https://test-tuk7.onrender.com/get-food-entries'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "userId": userId,
            "date": date.toIso8601String().split('T')[0],
          }),
        );

        if (response.statusCode == 200) {
          setState(() {
            _foodEntries = List<Map<String, dynamic>>.from(jsonDecode(response.body)['entries']);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error fetching data: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in')),
      );
    }
  }

  Future<void> _deleteFoodEntry(String foodId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null) {
      try {
        final response = await http.delete(
          Uri.parse('https://test-tuk7.onrender.com/delete-food/$foodId'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"userId": userId}),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Food entry deleted successfully')),
          );

          // Refresh food entries
          _fetchFoodEntriesForDate(_selectedDate!);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting entry: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in')),
      );
    }
  }

  Future<void> _editFoodEntry(String foodId) async {
    // Implement logic to edit the food entry (similar to adding a new entry)
    // You may want to show a dialog or navigate to a new page with fields pre-filled
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E2E2E), Color(0xFF121212)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Content on top of background image
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.0), // Space for status bar
                    Text(
                      'Edit Food Entries',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _buildFoodEntriesList(), // Method to build the list of food entries
                  ],
                ),
              ),
              // Calendar button
              Positioned(
                top: 40,
                right: 16,
                child: IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.white),
                  onPressed: _selectDate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodEntriesList() {
    return Expanded(
      child: _selectedDate == null
          ? Center(child: Text('Select a date to view food entries', style: TextStyle(color: Colors.white)))
          : ListView.builder(
        itemCount: _foodEntries.length,
        itemBuilder: (context, index) {
          final entry = _foodEntries[index];
          return Card(
            color: Colors.white.withOpacity(0.8),
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(entry['food']),
              subtitle: Text('Calories: ${entry['calories']}, Protein: ${entry['protein']}, Quantity: ${entry['quantity']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteFoodEntry(entry['_id']),
              ),
            ),
          );
        },
      ),
    );
  }
}
