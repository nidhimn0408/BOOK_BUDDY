import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      showError("Please fill all the details!");
    } else if (password != cPassword) {
      showError("Passwords do not match!");
    } else {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          // Only navigate if account creation is successful
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (ex) {
        handleError(ex.code);
      } catch (ex) {
        handleError("An unexpected error occurred");
      }
    }
  }

  void showError(String message) {
    // Display an error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void handleError(String errorCode) {
    String errorMessage = "An error occurred. Please try again.";
    switch (errorCode) {
      case "weak-password":
        errorMessage = "The password provided is too weak.";
        break;
      case "email-already-in-use":
        errorMessage = "The account already exists for that email.";
        break;
    // Add more cases for specific error codes if   needed
    }
    showError(errorMessage);
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
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
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
                              ),
                            ),
                            SizedBox(height: 20.0),
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
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: cPasswordController,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
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
                                // Implement sign-up logic here
                                createAccount();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF8D898E),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
