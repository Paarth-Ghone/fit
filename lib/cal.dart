import 'package:flutter/material.dart';

class CalorieTrackingPage extends StatefulWidget {
  @override
  _CalorieTrackingPageState createState() => _CalorieTrackingPageState();
}

class _CalorieTrackingPageState extends State<CalorieTrackingPage> {
  final TextEditingController _calorieLimitController = TextEditingController();

  @override
  void dispose() {
    _calorieLimitController.dispose();
    super.dispose();
  }

  void _setCalorieLimit() {
    final limit = _calorieLimitController.text;
    print('Daily Calorie Limit set to: $limit kcal');
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
                  Colors.black.withOpacity(0.6), // Adjusted to match login screen overlay
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
            _buildDetailRow('Total Calories Consumed:', '1500 kcal'),
            Divider(),
            _buildDetailRow('Daily Goal:', '2000 kcal'),
            Divider(),
            _buildDetailRow('Remaining Calories:', '500 kcal'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black87),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildCalorieLimitForm() {
    return TextField(
      controller: _calorieLimitController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Daily Calorie Limit (kcal)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildGradientButton() {
    return Container(
      width: 150, // Adjust the width as needed
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00FFCB), Color(0xFF008CFF)], // Use the same gradient as the login button
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ElevatedButton(
        onPressed: _setCalorieLimit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Make button background transparent
          shadowColor: Colors.transparent, // Remove button shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(
          'Set Limit',
          style: TextStyle(
            fontSize: 18.0,

            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
