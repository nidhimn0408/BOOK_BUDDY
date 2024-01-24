import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Navigator/navigation.dart';
import '../signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      // Provide feedback to the user about empty fields
      Get.snackbar("Error", "Please fill in all fields");
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        // Navigate to the home screen using GetX
        Get.offAll(() => NavigationMenu());
      }
    } on FirebaseAuthException catch (ex) {
      // Provide feedback to the user about authentication failure
      String errorMessage = "Authentication failed";

      switch (ex.code) {
        case "user-not-found":
          errorMessage = "User not found. Please check your email.";
          break;
        case "wrong-password":
          errorMessage = "Wrong password. Please try again.";
          break;
      // Add more cases as needed
      }

      Get.snackbar("Error", errorMessage);
    } catch (ex) {
      // Handle other exceptions
      Get.snackbar("Error", "An unexpected error occurred. Please try again later.");
      log("Unexpected error during login: $ex");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD3AFE0),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 10,
                  right: 10,
                  child: Image.asset(
                    'assets/images/book.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Book Buddy',
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                obscureText: false,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: () {
                                // Implement your login logic here
                                login();
                              },
                              child: Text('Log In'),
                            ),
                            SizedBox(height: 10.0),
                            TextButton(
                              onPressed: () {
                                // Navigate to SignUp page
                                Get.to(() => const SignUp());
                              },
                              child: Text(
                                'Create New Account',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
