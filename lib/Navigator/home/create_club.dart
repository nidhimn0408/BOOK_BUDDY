// create_club.dart
import 'package:flutter/material.dart';

class CreateClubPage extends StatelessWidget {
  const CreateClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x93664FA4),
        title: const Text('Create Book Club'),
      ),
      body: Container(
        color: const Color(0x93664FA4),
        padding: const EdgeInsets.all(16.0),
        child: const Column(
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
