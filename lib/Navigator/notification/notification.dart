// notifications.dart
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD3AFE0),
        title: Text('Notifications'),
      ),
      body: Container(
        color: Color(0xFFD3AFE0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Unread Messages:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  NotificationMessageWidget(
                    message: 'You have a new friend request.',
                    isRead: false,
                  ),
                  NotificationMessageWidget(
                    message: 'Your post received 10 likes.',
                    isRead: false,
                  ),
                  NotificationMessageWidget(
                    message: 'Congratulations! You earned a badge.',
                    isRead: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add logic to mark all messages as read
                },
                child: Text('Mark All as Read'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Color(0xFFD3AFE0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationMessageWidget extends StatelessWidget {
  final String message;
  final bool isRead;

  NotificationMessageWidget({required this.message, required this.isRead});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isRead ? Colors.grey[300] : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        message,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
