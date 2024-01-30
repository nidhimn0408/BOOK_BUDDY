import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../login/login.dart';
import '../profile/profile.dart';
import 'create_club.dart';
import 'my_books/my_books.dart';
import 'notification/notification.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => LoginPage()),
    );
  }

  Future<void> _confirmLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                logOut();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Display confirmation dialog
              _confirmLogoutDialog();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 250.0),
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
            Image.asset(
              'assets/images/group.jpg', // Replace with your image path
              width: 400.0,
              height: 200.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Are you a member of any club?',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement Join Club logic here
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 30.0,
                    ),
                  ),
                  child: const Text('Join Club'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to CreateClubPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateClubPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 30.0,
                    ),
                  ),
                  child: const Text('Create Club'),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            const Text(
              'Track your progress',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement My Book logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const myBook()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 30.0,
                    ),
                  ),
                  child: const Text('My Books'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement Notification logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NotificationsPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 30.0,
                    ),
                  ),
                  child: const Text('Notification'),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
    );
  }
}
