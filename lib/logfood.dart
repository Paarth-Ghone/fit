import 'package:flutter/material.dart';

class FoodIntakeLoggingPage extends StatefulWidget {
  @override
  _FoodIntakeLoggingPageState createState() => _FoodIntakeLoggingPageState();
}

class _FoodIntakeLoggingPageState extends State<FoodIntakeLoggingPage> {
  final List<Map<String, dynamic>> _foodEntries = [];
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  int _totalCalories = 0;

  @override
  void dispose() {
    _foodController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  void _addFoodEntry() {
    final String food = _foodController.text;
    final int? calories = int.tryParse(_caloriesController.text);

    if (food.isNotEmpty && calories != null && calories > 0) {
      setState(() {
        _foodEntries.add({'food': food, 'calories': calories});
        _totalCalories += calories;
      });

      _foodController.clear();
      _caloriesController.clear();
    }
  }

  void _deleteFoodEntry(int index) {
    if (index < _foodEntries.length) {
      setState(() {
        _totalCalories -= _foodEntries[index]['calories'] as int;
        _foodEntries.removeAt(index);
      });
    }
  }

  void _editFoodEntry(int index) {
    if (index < _foodEntries.length) {
      setState(() {
        _foodController.text = _foodEntries[index]['food'];
        _caloriesController.text = _foodEntries[index]['calories'].toString();
        _deleteFoodEntry(index);
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
                  child: ElevatedButton(
                    onPressed: _addFoodEntry,
                    child: Text('Add Food'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.deepPurpleAccent,
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _buildTotalCalories(),
                SizedBox(height: 20.0),
                Expanded(
                  child: _buildFoodList(),
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
      ],
    );
  }

  Widget _buildTotalCalories() {
    return Card(
      elevation: 4.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Calories for the Day:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 8.0),
            Text(
              '$_totalCalories kcal',
              style: TextStyle(fontSize: 24.0, color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodList() {
    return ListView.builder(
      itemCount: _foodEntries.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            title: Text(
              _foodEntries[index]['food'],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            subtitle: Text('${_foodEntries[index]['calories']} kcal'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blueAccent),
                  onPressed: () => _editFoodEntry(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => _deleteFoodEntry(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
