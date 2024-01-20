import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'Navigator/home/home.dart';
import 'Navigator/navigation.dart';
import 'login/login.dart';
import 'package:get/get.dart';
import '../signup/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Book Buddy',
      home:  LoginPage(),
    );
  }
}
