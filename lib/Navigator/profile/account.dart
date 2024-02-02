import 'dart:ui';
import 'package:bookbuddy/Navigator/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../login/login.dart';

final _fs = FirebaseFirestore.instance;

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _ListBuilder {
  late final String data;
  late final IconData leadIcon;
  late final bool trailIcon;
  late final Color col;
  late final Function() onTap;

  _ListBuilder({
    required this.data,
    required this.leadIcon,
    this.trailIcon = true,
    required this.onTap,
    this.col = Colors.black54,
  });

  GestureDetector buildListTile() {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.black54),
          child: Icon(
            leadIcon,
            color: Colors.white,
          ),
        ),
        title: Text(
          data,
          style: GoogleFonts.rajdhani(
              fontSize: 25, fontWeight: FontWeight.w700, color: col),
        ),
        trailing: trailIcon
            ? Container(
          width: 40,
          height: 40,
        )
            : null,
      ),
    );
  }
}

class _AccountState extends State<Account> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<Map<String, dynamic>?> _editProfile() async {
    var userData = await getUserData();

    var updatedData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile(mpp: userData)),
    );

    return updatedData;
  }


  get defImg =>
      "https://firebasestorage.googleapis.com/v0/b/bookbuddy-62925.appspot.com/o/images%2F1706677934840?alt=media&token=15bb1dc5-9978-4e3d-b043-8471d88e42cd";

  void _showSnackBar(String message, Color col) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: col,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void signOut() {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Text(
              "Logout Confirmation",
              style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
            content: Text(
              "Are you sure you want to log out?",
              style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  "No",
                  style: GoogleFonts.rajdhani(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (context) => LoginPage()),
                    );
                  } catch (e) {
                    _showSnackBar(
                        "Couldn't Log Out, try again! ${e.toString()}",
                        Colors.red);
                  }
                },
                child: Text(
                  "Yes",
                  style: GoogleFonts.rajdhani(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> getUserData() async {
    try {
      var id = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot res1 = await _fs.collection("users").doc(id).get();

      DocumentSnapshot res2 =
      await _fs.collection("user_details").doc(id).get();

      Map<String, dynamic>? data1 =
          res1.data() as Map<String, dynamic>? ?? {};
      Map<String, dynamic>? data2 =
          res2.data() as Map<String, dynamic>? ?? {};

      return {
        "user_name": data1?['user_name'] ?? "Profile",
        "email": data1?['email'] ?? "genericemail@gmail.com",
        "address": data2?['address'] ?? "",
        "profile_pic": data2?['profile_pic'] ?? defImg,
        "age": data2?['age'] ?? -1,
        "phone_number": data2?['phone_number'] ?? -1,
      };
    } catch (e) {
      return {
        'user_name': 'Profile',
        'email': 'genericemail@gmail.com',
        'address': '',
        'profilePic': defImg,
        'age': -1,
        "phone_number": -1,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: secondary,
      // appBar: CustomTopAppBar(
      //   text: "Account Details",
      //   show: true,
      //   context: context,
      // ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapShot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Error",
                    style: GoogleFonts.rajdhani(
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            );
          } else {
            Map<String, dynamic> data =
                snapShot.data ?? {"user_name": "Profile", "email": "genericemail@gmail.com", "address": "`", "profile_pic": defImg, "age": -1, "phone_number": -1};
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(top: 10),
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(data["profile_pic"])),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      "${data["user_name"]}",
                      style: GoogleFonts.rajdhani(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "${data["email"]}",
                      style: GoogleFonts.rajdhani(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async {
                    var updatedData = await _editProfile();
                    if (updatedData != null) {
                      setState(() {
                        // Update the user data in the Account page
                        // You may need to handle the data accordingly based on your implementation
                      });
                    }
                    // Call any other logic you want to perform after the profile is edited
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(327, 50),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 1,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  child: Text(
                    "Edit Profile",
                    style: GoogleFonts.rajdhani(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),

                    const SizedBox(height: 20,),
                    const Divider(),
                    const SizedBox(height: 10,),
                    _ListBuilder(
                      data: "Age: ${data["age"] == -1 ? 'N/A' : data["age"]}",
                      leadIcon: Icons.account_box_outlined,
                      trailIcon: false,
                      onTap: () {},
                    ).buildListTile(),
                    _ListBuilder(
                      data: "Address",
                      leadIcon: Icons.map,
                      trailIcon: false,
                      onTap: () {},
                    ).buildListTile(),
                    _ListBuilder(
                      data: "Log Out",
                      leadIcon: Icons.logout,
                      col: Colors.red,
                      onTap: signOut,
                    ).buildListTile(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
