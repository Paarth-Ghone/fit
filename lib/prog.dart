import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:untitled1/misc/colors.dart'; // Make sure you have the same color definitions here

class ProgressTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E2E2E), Color(0xFF121212)], // Same gradient as login page
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0), // For status bar height, adjust as needed
              Text(
                'Your Progress',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for better contrast
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: ListView(
                  children: [
                    _buildProgressCard(
                      title: 'Weight Lifted Over Time',
                      child: _buildLineChart(),
                    ),
                    _buildProgressCard(
                      title: 'Calories Burned',
                      child: _buildBarChart(),
                    ),
                    _buildProgressCard(
                      title: 'Workout Consistency',
                      child: _buildPieChart(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard({required String title, required Widget child}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Rounded corners
      ),
      elevation: 6.0,
      color: Colors.black.withOpacity(0.5), // Semi-transparent card background
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text to match the theme
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: 200.0,
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        backgroundColor: Colors.transparent, // Transparent background
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 50),
              FlSpot(1, 100),
              FlSpot(2, 150),
              FlSpot(3, 200),
              FlSpot(4, 250),
            ],
            isCurved: true,
            color: Colors.greenAccent, // Use green accent for charts
            barWidth: 4,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [Colors.greenAccent.withOpacity(0.5), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        backgroundColor: Colors.transparent, // Transparent background
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: 500,
                color: Colors.greenAccent, // Use green accent for bars
                width: 15,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: 700,
                color: Colors.greenAccent,
                width: 15,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: 600,
                color: Colors.greenAccent,
                width: 15,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: 800,
                color: Colors.greenAccent,
                width: 15,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 40,
            color: Colors.greenAccent,
            title: '40%',
            titleStyle: TextStyle(color: Colors.white, fontSize: 14),
          ),
          PieChartSectionData(
            value: 30,
            color: Colors.blueAccent,
            title: '30%',
            titleStyle: TextStyle(color: Colors.white, fontSize: 14),
          ),
          PieChartSectionData(
            value: 20,
            color: Colors.orangeAccent,
            title: '20%',
            titleStyle: TextStyle(color: Colors.white, fontSize: 14),
          ),
          PieChartSectionData(
            value: 10,
            color: Colors.redAccent,
            title: '10%',
            titleStyle: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
