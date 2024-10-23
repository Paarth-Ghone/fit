import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'viewreplies.dart';

class ComplaintsPage extends StatefulWidget {
  @override
  _ComplaintsPageState createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  final TextEditingController _complaintController = TextEditingController();
  String? reply;
  bool hasReply = false; // Track if a reply exists
  bool isLoading = false;
  String? userId; // Store userId here

  @override
  void initState() {
    super.initState();
    _fetchUserId(); // Fetch userId when the page loads
  }

  Future<void> _fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
    print('Fetched userId: $userId'); // Debug line
  }

  Future<void> _submitComplaint() async {
    if (hasReply) return; // Prevent submission if there's a reply

    if (_complaintController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a complaint before submitting.'),
      ));
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName'); // Assuming you store userName in SharedPreferences

    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse('https://test-tuk7.onrender.com/complaints'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'userName': userName, // Send userName along with userId
        'text': _complaintController.text
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Complaint submitted successfully!'),
      ));
      _complaintController.clear();
      await _fetchReply(); // Fetch reply after submitting a complaint
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to submit complaint: ${response.body}'), // More info
      ));
      print('Error submitting complaint: ${response.body}'); // Debug line
    }
  }

  Future<void> _fetchReply() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('https://test-tuk7.onrender.com/complaints/$userId'));

    print('Fetching reply for userId: $userId'); // Debug line

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print('Response body: ${response.body}'); // Log the response body

      if (data.isNotEmpty) {
        final latestComplaint = data.first; // Get the latest complaint
        reply = latestComplaint['reply']; // Get the reply for the latest complaint
        hasReply = reply != null && reply!.isNotEmpty; // Check if there's a reply
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No complaints found.'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load complaint: ${response.body}'), // More info
      ));
      print('Error fetching complaints: ${response.body}'); // Debug line
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Apply gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E2E2E), Color(0xFF121212)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: [
            TextField(
              controller: _complaintController,
              maxLines: 4,
              enabled: !hasReply, // Disable input if there's a reply
              style: TextStyle(color: Colors.white), // Change text color if needed
              cursorColor: Colors.white, // Cursor color
              decoration: InputDecoration(
                labelText: 'Your Complaint',
                labelStyle: TextStyle(color: Colors.white), // Label color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.white), // Border color
                ),
              ),
            ),
            SizedBox(height: 16.0),
            _buildGradientButton(
              onPressed: hasReply ? null : _submitComplaint,
              text: 'Submit Complaint',
            ),
            SizedBox(height: 20.0),
            _buildGradientButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewRepliesPage()), // Navigate to ViewRepliesPage
                );
              },
              text: 'View Replies',
            ),
            SizedBox(height: 20.0),
            if (hasReply) ...[
              Text('Admin Reply:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8.0),
              Text(reply ?? 'No reply yet', style: TextStyle(color: Colors.white)), // Show admin reply if available
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton({required VoidCallback? onPressed, required String text}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00FFCB), Color(0xFF008CFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8), // Match the border radius to the text field
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 12), // Adjust padding to match button size
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white), // Adjust font size to match
        ),
      ),
    );
  }
}
