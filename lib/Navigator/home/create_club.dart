// create_club.dart
import 'package:flutter/material.dart';

class CreateClubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD3AFE0),
        title: Text('Create Book Club'),
      ),
      body: Container(
        color: Color(0xFFD3AFE0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Add your widgets for creating a book club
            Text(
              'Create a new Book Club',
              style: TextStyle(fontSize: 18),
            ),
            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}
