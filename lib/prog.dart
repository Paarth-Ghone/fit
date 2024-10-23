import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImportantNoticesPage extends StatefulWidget {
  @override
  _ImportantNoticesPageState createState() => _ImportantNoticesPageState();
}

class _ImportantNoticesPageState extends State<ImportantNoticesPage> {
  List<dynamic> notices = [];

  @override
  void initState() {
    super.initState();
    _fetchNotices();
  }

  Future<void> _fetchNotices() async {
    final response = await http.get(Uri.parse('https://test-tuk7.onrender.com/notices'));

    if (response.statusCode == 200) {
      setState(() {
        notices = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load notices');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Important Notices', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF2E2E2E), // Dark color to match the theme
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E2E2E), Color(0xFF121212)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _buildNoticeList(),
      ),
    );
  }

  Widget _buildNoticeList() {
    if (notices.isEmpty) {
      return Center(child: Text('No notices available', style: TextStyle(color: Colors.white)));
    }

    return ListView.builder(
      itemCount: notices.length,
      itemBuilder: (context, index) {
        final notice = notices[index];
        return Card(
          margin: EdgeInsets.all(10.0),
          color: Colors.black, // Background color for the card
          child: ListTile(
            title: Text(
              notice['title'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            subtitle: Text(
              notice['description'],
              style: TextStyle(fontSize: 16, color: Colors.grey[400]), // Light grey for description
            ),
            onTap: () {
              // Optional: Navigate to a detailed notice page
            },
          ),
        );
      },
    );
  }
}
