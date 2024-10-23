import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ViewRepliesPage extends StatefulWidget {
  @override
  _ViewRepliesPageState createState() => _ViewRepliesPageState();
}

class _ViewRepliesPageState extends State<ViewRepliesPage> {
  List<dynamic> complaints = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchComplaints(); // Fetch complaints when the page loads
  }

  Future<void> _fetchComplaints() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    final response = await http.get(Uri.parse('https://test-tuk7.onrender.com/complaints/$userId'));

    if (response.statusCode == 200) {
      setState(() {
        complaints = json.decode(response.body); // Store the fetched complaints
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load complaints: ${response.body}'), // More info
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Replies',  style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF2E2E2E), // Match the gradient start color
      ),
      body: Container(
        // Apply gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E2E2E), Color(0xFF121212)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: complaints.length,
          itemBuilder: (context, index) {
            final complaint = complaints[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              color: Color(0xFF1E1E1E), // Dark card background
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Complaint:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 8.0),
                    Text(complaint['text'] ?? 'No complaint text', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 16.0),
                    Text('Admin Reply:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 8.0),
                    Text(complaint['reply'] ?? 'No reply yet', style: TextStyle(color: Colors.white)), // Display the reply if available
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
