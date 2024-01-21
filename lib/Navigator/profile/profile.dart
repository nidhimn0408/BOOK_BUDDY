import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD3AFE0),
      appBar: AppBar(
        backgroundColor: Color(0xFFD3AFE0),
        title: Text('PROFILE', style: TextStyle(fontSize: 20) ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User Profile Information
            CircleAvatar(
              radius: 50,
              // You can replace the placeholder image with the user's profile picture
              backgroundImage: AssetImage('assets/images/symbol.jpg'),
            ),
            SizedBox(height: 8),
            Text(
              'John Doe', // Replace with the user's name
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'johndoe@example.com', // Replace with the user's email
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Edit profile', // Replace with the user's email
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            // Additional user details or preferences can be displayed here
            SizedBox(height: 8),
            BookStrip(
              leftText: 'Currently Reading Books ',
              rightText: '>',
              onPressed: () {

              },
            ),
            SizedBox(height: 8),
            BookStrip(
              leftText: 'Join Book Club',
              rightText: '>',
              onPressed: () {

              },
            ),
            SizedBox(height: 8),
            BookStrip(
              leftText: 'Create Book Club',
              rightText: '>',
              onPressed: () {

              },
            ),
            SizedBox(height: 8),
            BookStrip(
              leftText: 'Privacy Settings',
              rightText: '>',
              onPressed: () {

              },
            ),
            SizedBox(height: 8),
            BookStrip(
              leftText: 'Email and Notification Setting',
              rightText: '>',
              onPressed: () {

              },
            ),
            SizedBox(height: 8),
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

  BookStrip({
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
        color: Color(0xFF9B579D), // You can change the color as needed
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                leftText,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                rightText,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}