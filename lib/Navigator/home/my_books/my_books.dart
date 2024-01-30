import 'package:flutter/material.dart';

import '../../../AddNewBook/AddNewBook.dart';
import '../../../Homepage/HomePage.dart';
import '../../profile/profile.dart';

class myBook extends StatefulWidget {
  const myBook({super.key});

  @override
  State<myBook> createState() => _ProfileState();
}

class _ProfileState extends State<myBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3AFE0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD3AFE0),
        title: const Text('MY BOOKS', style: TextStyle(fontSize: 20) ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Currently Reading',
              rightText: '>',
              onPressed: () {

              },
            ),
            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Favourite Books',
              rightText: '>',
              onPressed: () {

              },
            ),
            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Past books',
              rightText: '>',
              onPressed: () {

              },
            ),
            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Books I want to read',
              rightText: '>',
              onPressed: () {

              },
            ),
            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Edit Profile',
              rightText: '>',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile(mpp: {},)),
                );

              },
            ),
            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Explore Books',
              rightText: '>',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );

              },
            ),
            const SizedBox(height: 8),
            BookStrip(
              leftText: 'Add new Books',
              rightText: '>',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddNewBookPage()),
                );

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