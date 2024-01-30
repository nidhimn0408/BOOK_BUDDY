import 'package:bookbuddy/Navigator/profile/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';





import '../Homepage/Homepage.dart';
import '../signup/signup.dart';
import 'chat/chat.dart';
import 'home/home.dart';
import '../AddNewBook/AddNewBook.dart';
import 'notification/notification.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _homeState();
}

class _homeState extends State<NavigationMenu> {
  int index=0;
  final screens=[
    const Home(),
    const ChatScreen(),
    const HomePage(),
    const Profile(),
    const AddNewBookPage()
  ];
  @override
  Widget build(BuildContext context) {
    final items= [
      const Icon(Icons.home),
      const Icon(Icons.message_outlined),
      const Icon(Icons.menu_book),
      const Icon(Icons.person),
      const Icon(Icons.add),



    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(
            milliseconds: 100),

        items: items,
        index: index,
        onTap: (index) =>
            setState(() {
              this.index=index;
            }),

      ),
    );



  }
}