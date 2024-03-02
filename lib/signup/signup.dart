import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../login/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
get defImg =>
    "https://firebasestorage.googleapis.com/v0/b/bookbuddy-62925.appspot.com/o/images%2F1706677934840?alt=media&token=15bb1dc5-9978-4e3d-b043-8471d88e42cd";

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
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          password: password,
          email: email,
        ).then((result) async {
          if(result.user != null){
            User? u = FirebaseAuth.instance.currentUser;
            String? userId = u!.uid;
            await FirebaseFirestore.instance.collection('users')
                .doc(userId)
                .set({
              'email': email,
              'user_name': " ",
            }).then((value) async {
              await FirebaseFirestore.instance.collection("user_details")
                  .doc(userId)
                  .set({
                'user_id': userId,
                'address': "`",
                'age': -1,
                'phone_number': -1,
                'profile_pic': defImg,
              }).then((res) {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              });
            });
          }
        });
      }
      on FirebaseAuthException catch (ex) {
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
      backgroundColor: const Color(0x93664FA4),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 30.0),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
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
                            const SizedBox(height: 20.0),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
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
                            const SizedBox(height: 20.0),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
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
                            const SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: () {
                                // Implement sign-up logic here
                                createAccount();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8D898E),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 100.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              child: const Text(
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