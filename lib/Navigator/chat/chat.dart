// chat.dart
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String?> people = ['John', 'Alice', 'Bob', 'Eve'];
  String? selectedPerson;
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x93664FA4),
        title: const Text('Chat Screen'),
      ),
      body: Container(
        color: const Color(0x93664FA4),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Select a person to chat:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8.0),
                  DropdownButton<String?>(
                    value: selectedPerson,
                    items: people.map((String? person) {
                      return DropdownMenuItem<String?>(
                        value: person,
                        child: Text(person ?? ''),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPerson = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return messages[index];
                        },
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              hintText: 'Type a message...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            _sendMessage();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (selectedPerson != null && messageController.text.isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          isSent: true,
          text: messageController.text,
        ));
        // messages.add(ChatMessage(
        //   isSent: false,
        //   text: 'Received: ${messageController.text}',
        // ));
         messageController.clear();
      });
    }
  }
}

class ChatMessage extends StatelessWidget {
  final bool isSent;
  final String text;

  const ChatMessage({super.key, required this.isSent, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: isSent ? const Color(0xFFD3AFE0) : Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(text),
      ),
    );
  }
}
