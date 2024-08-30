import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String imageName;
  final String imageDescription;

  const DetailsPage({
    Key? key,
    required this.imageName,
    required this.imageDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageDescription),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("img/$imageName"),
            SizedBox(height: 20),
            Text(
              imageDescription,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
