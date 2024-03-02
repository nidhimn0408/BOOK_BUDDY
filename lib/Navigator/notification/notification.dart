// notifications.dart
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD3AFE0),
        title: const Text('Notifications'),
      ),
      body: Container(
        color: const Color(0xFFD3AFE0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Unread Messages:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView(
                children: const [
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
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add logic to mark all messages as read
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFFD3AFE0), backgroundColor: Colors.white,
                ),
                child: const Text('Mark All as Read'),
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

  const NotificationMessageWidget({super.key, required this.message, required this.isRead});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isRead ? Colors.grey[300] : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
