import 'package:bookbuddy/Navigator/profile/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




import 'package:velocity_x/velocity_x.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:io';

import '../login/login.dart';
import '../signup/signup.dart';
import 'home/home.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _homeState();
}

class _homeState extends State<NavigationMenu> {
  int index=0;
  final screens=[
    HomePage(),
    SignUp(),
    LoginPage(),
    Profile(),
    LoginPage()

  ];
  @override
  Widget build(BuildContext context) {
    final items= [
      Icon(Icons.home),
      Icon(Icons.person_add_outlined),
      Icon(Icons.menu_book),
      Icon(Icons.supervised_user_circle),
      Icon(Icons.notification_add),



    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationDuration: Duration(
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