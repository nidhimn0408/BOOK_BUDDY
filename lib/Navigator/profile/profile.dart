import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3AFE0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD3AFE0),
        title: const Text('PROFILE', style: TextStyle(fontSize: 20) ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User Profile Information
            const CircleAvatar(
              radius: 50,
              // You can replace the placeholder image with the user's profile picture
              backgroundImage: AssetImage('assets/images/symbol.jpg'),
            ),
            const SizedBox(height: 8),
            const Text(
              'John Doe', // Replace with the user's name
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'johndoe@example.com', // Replace with the user's email
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Edit profile', // Replace with the user's email
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            // Additional user details or preferences can be displayed here
            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Currently Reading Books ',
              rightText: '>',
              onPressed: () {

              },
            ),
            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Join Book Club',
              rightText: '>',
              onPressed: () {

              },
            ),
            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Create Book Club',
              rightText: '>',
              onPressed: () {

              },
            ),
            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Privacy Settings',
              rightText: '>',
              onPressed: () {

              },
            ),
            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Email and Notification Setting',
              rightText: '>',
              onPressed: () {

              },
            ),
            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Delete My Account',
              rightText: '>',
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}

class BookStrip extends StatelessWidget {
  final String leftText;
  final String rightText;
  final VoidCallback onPressed;

  const BookStrip({super.key, 
    required this.leftText,
    required this.rightText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        color: const Color(0xFF9B579D), // You can change the color as needed
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                leftText,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                rightText,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}