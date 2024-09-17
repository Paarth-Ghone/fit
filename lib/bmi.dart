import 'package:flutter/material.dart';

class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double _bmi = 0;
  String _bmiCategory = "";
  String _idealWeightRange = "";
  String _healthTip = "";

  void _calculateBMI() {
    final double height = double.parse(_heightController.text) / 100;
    final double weight = double.parse(_weightController.text);
    setState(() {
      _bmi = weight / (height * height);
      _determineBMICategory();
      _calculateIdealWeightRange(height);
      _provideHealthTip();
    });
  }

  void _determineBMICategory() {
    if (_bmi < 18.5) {
      _bmiCategory = "Underweight";
    } else if (_bmi >= 18.5 && _bmi < 24.9) {
      _bmiCategory = "Normal weight";
    } else if (_bmi >= 25 && _bmi < 29.9) {
      _bmiCategory = "Overweight";
    } else {
      _bmiCategory = "Obesity";
    }
  }

  void _calculateIdealWeightRange(double height) {
    final double lowerBound = 18.5 * height * height;
    final double upperBound = 24.9 * height * height;
    _idealWeightRange = "${lowerBound.toStringAsFixed(1)} kg - ${upperBound.toStringAsFixed(1)} kg";
  }

  void _provideHealthTip() {
    switch (_bmiCategory) {
      case "Underweight":
        _healthTip = "Consider a balanced diet with more calories and strength training.";
        break;
      case "Normal weight":
        _healthTip = "Maintain your current lifestyle with a balanced diet and regular exercise.";
        break;
      case "Overweight":
        _healthTip = "Incorporate more physical activity and watch your caloric intake.";
        break;
      case "Obesity":
        _healthTip = "Consult a healthcare provider for personalized advice on weight management.";
        break;
      default:
        _healthTip = "";
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
              'img/bmi.png', // Update with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Content on top of background image
          Container(
            color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.0), // Space for status bar
                Text(
                  'Enter your details',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0),
                _buildInputField('Height (cm)', _heightController),
                SizedBox(height: 10.0),
                _buildInputField('Weight (kg)', _weightController),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00FFCB), Color(0xFF008CFF)], // Gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: TextButton(
                    onPressed: _calculateBMI,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0), // Text color
                      backgroundColor: Colors.transparent, // Background color for the TextButton
                    ),
                    child: Text(
                      'Calculate BMI',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _bmi != 0
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your BMI: ${_bmi.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Category: $_bmiCategory',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Ideal Weight Range: $_idealWeightRange',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Health Tip: $_healthTip',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Card(
      elevation: 4.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
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
