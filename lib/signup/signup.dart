import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD3AFE0),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: Image.asset(
              'assets/images/symbol.png', // Replace with the path to your logo image
              width: 80,
              height: 80,
            ),
          ),
          Center(
            child: Container(
              width: 320.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'BOOK BUDDY',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9), // Background color D9D9D9
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        _buildInputField('Username'),
                        SizedBox(height: 20.0),
                        _buildInputField('Email'),
                        SizedBox(height: 20.0),
                        _buildInputField('Password'),
                        SizedBox(height: 20.0),
                        _buildInputField('Confirm Password'),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            // Implement sign-up logic here
                            Get.to(() => const LoginPage());
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF8D898E), // Button color 8D898E
                            padding: EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 85.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        labelText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      obscureText: hintText.toLowerCase().contains('password'),
    );
  }
}