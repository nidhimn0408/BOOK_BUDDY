import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentlyReadingPage extends StatefulWidget {
  final String userId;

  CurrentlyReadingPage({required this.userId});

  @override
  _CurrentlyReadingPageState createState() => _CurrentlyReadingPageState();
}

class _CurrentlyReadingPageState extends State<CurrentlyReadingPage> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _currentlyReadingStream;

  @override
  void initState() {
    super.initState();
    _currentlyReadingStream = FirebaseFirestore.instance
        .collection('currently_reading')
        .where('user_id', isEqualTo: widget.userId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currently Reading'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _currentlyReadingStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No books currently being read.'));
          }

          var currentlyReadingBooks = snapshot.data!.docs;

          return ListView.builder(
            itemCount: currentlyReadingBooks.length,
            itemBuilder: (context, index) {
              var bookId = currentlyReadingBooks[index]['title']; // Assuming you have a 'book_id' field in 'currently_reading' documents
              return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance.collection('books').doc(bookId).get(),
                builder: (context, bookSnapshot) {
                  if (bookSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!bookSnapshot.hasData || !bookSnapshot.data!.exists) {
                    return Center(child: Text('Book not found.'));
                  }

                  var bookData = bookSnapshot.data!.data();
                  return ListTile(
                    title: Text(bookData!['title']),
                    subtitle: Text(bookData['author']),
                    // Add more book details as needed
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CurrentlyReadingPage(userId: 'user123'), // Replace with the actual user ID
    );
  }
}
