import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../login/login.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD3AFE0),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement your logout logic here
              Get.to(() => const LoginPage());
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 250.0),
            child: Image.asset(
              'assets/images/book.png', // Replace with your image path
              width: 80.0,
              height: 80.0,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/group.jpg', // Replace with your image path
              width: 400.0,
              height: 200.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Are you a member of any club?',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement Join Club logic here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF753F7D),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 30.0,
                    ),
                  ),
                  child: Text('Join Club'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement Create Club logic here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF753F7D),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 30.0,
                    ),
                  ),
                  child: Text('Create Club'),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFD3AFE0),
    );
  }
}
