import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Homepage/Widgets/top_app_bar.dart';
import '../../login/login.dart';

class Profile extends StatefulWidget {
  final Map<String, dynamic> mpp;

  const Profile({super.key, required this.mpp});

  @override
  State<Profile> createState() => _EditProfileState();
}

class _EditProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  get defImg => "https://firebasestorage.googleapis.com/v0/b/bookbuddy-62925.appspot.com/o/images%2F1706677934840?alt=media&token=15bb1dc5-9978-4e3d-b043-8471d88e42cd";

  get secondary => null;

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
  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => LoginPage()),
    );
  }

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController phNoCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();

  Future<Map<String, dynamic>> saveProfile(Map<String, dynamic> mpp) async {
    log("Called");
    String name = nameCtrl.text;
    String address = addressCtrl.text;
    String phNostr = phNoCtrl.text.trim();
    String ageStr = ageCtrl.text.trim();
    int? phNo = -1;
    int? age;

    if(ageStr != "") {
      age = int.tryParse(ageStr);
    } else {
      age ??= (mpp['phone_number']!=-1)?mpp['age']:-1;
    }

    log("Here");

    if(name == '') name = mpp['user_name'];
    log("Here");

    if(address == '') address = mpp['address'];
    log("Here");

    if(phNostr.isEmpty){
      phNo = (mpp['phone_number']!=-1)?mpp['phone_number']:phNo;
    }
    else if(phNostr.length != 10) {
      phNo = (mpp['phone_number']!=-1)?int.parse(phNostr):phNo;
    } else {
      phNo = int.tryParse(phNostr);
      phNo ??= (mpp['phone_number']!=-1)?mpp['phone_number']:-1;
    }
    log("Here");

    age ??= (mpp['phone_number']!=-1)?mpp['age']:-1;
    log("Here1");
    showDialog(
        context: context,
        builder: (context) {
          log("Here2");
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: AlertDialog(
              backgroundColor: Colors.deepPurpleAccent,
              title: Text(
                "Save Profile?",
                style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700
                ),
              ),
              content: Text(
                "Are you sure you want to save your details?",
                style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "No",
                    style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context, true);
                  },

                  child: Text(
                    "Yes",
                    style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );

    return mpp;
  }

  void deleteProfile(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "Save Profile?",
          style: GoogleFonts.rajdhani(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          "Are you sure you want to save your details?",
          style: GoogleFonts.rajdhani(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              "No",
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              // Your save profile logic
              Navigator.of(context).pop(true); // Return true
            },
            child: Text(
              "Yes",
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );

  }

  void imagePicker() async{
    // Get File path
    ImagePicker imgPick = ImagePicker();
    XFile? img = await imgPick.pickImage(source: ImageSource.gallery);
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

    // Upload to DB
    Reference reference = FirebaseStorage.instance.ref().child("images");
    Reference refImgToUpload = reference.child(uniqueName);
    String imgURL;
    try{
      await refImgToUpload.putFile(File(img!.path));
      imgURL = await refImgToUpload.getDownloadURL();
      await FirebaseFirestore.instance.collection("user_details").doc(FirebaseAuth.instance.currentUser!.uid).set({
        "profile_pic": imgURL,
      }).then((res) {
        setState(() {});
      });
    }
    catch(e){
      _showSnackBar("Image Couldn't Be uploaded", Colors.red);
      Future.delayed(const Duration(seconds: 0)).then((value) => Navigator.of(context).pop());
    }
  }

  Future<void> _confirmLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                logOut();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Vx.purple300,
        appBar: AppBar(
          foregroundColor: Colors.white, backgroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Display confirmation dialog
                _confirmLogoutDialog();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 250.0),
              child: Image.asset(
                'assets/images/book.png', // Replace with your image path
                width: 80.0,
                height: 80.0,
              ),
            ),
          ],
        ),
        body: Builder(
            builder: (context) {
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              // margin: const EdgeInsets.only(top: 10),
                              width: 120, height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(widget.mpp['profile_pic']??defImg)),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => imagePicker(),
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.black54
                                    ),
                                    child: const Icon(Icons.add_a_photo_rounded, color: Colors.white,),
                                  ),
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 2,),
                        Form(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    width: 30,
                                    height: 10,
                                    // decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(100),
                                    //     color: Colors.black54
                                    // ),
                                    //child: ClipRRect(
                                        //borderRadius: BorderRadius.circular(100),
                                        //child: const Icon(Icons.email, color: Colors.white,)
                                    //),
                                  ),
                                  // title: Text(
                                  //   "${widget.mpp['email']??"genericemail@gmail.com"}",
                                  //   style: GoogleFonts.rajdhani(
                                  //       fontSize: 20,
                                  //       fontWeight: FontWeight.w700,
                                  //       color: Colors.white
                                  //   ),
                                  // ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: TextField(
                                    controller: nameCtrl,
                                    decoration: InputDecoration(
                                        hintText: "${widget.mpp['user_name']??"Profile"}",
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(80),
                                        ),
                                        prefixIcon: const Icon(Icons.person)
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: TextField(
                                    controller: addressCtrl,
                                    decoration: InputDecoration(
                                        hintText: "${(widget.mpp['address']!='`')?widget.mpp['address'] : "Address"}",
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(80),
                                        ),
                                        prefixIcon: const Icon(Icons.location_on)
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: TextField(
                                    controller: phNoCtrl,
                                    decoration: InputDecoration(
                                        hintText: "${(widget.mpp['phone_number']!=-1)?widget.mpp['phone_number'] : "Not set yet"}",
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(80),
                                        ),
                                        prefixIcon: const Icon(Icons.phone_android)
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2,),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: TextField(
                                    controller: ageCtrl,
                                    decoration: InputDecoration(
                                        hintText: "${(widget.mpp['age']!=-1)?widget.mpp['age'] : "Not set yet"}",
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(80),
                                        ),
                                        prefixIcon: const Icon(Icons.accessibility_new_outlined)
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async{
                                    await saveProfile(widget.mpp).then((updatedData){
                                      Navigator.of(context).pop(updatedData);
                                      setState(() {});
                                    }
                                    );
                                  },

                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(327, 50),
                                      backgroundColor: Colors.black87,
                                      foregroundColor: Colors.white,
                                      elevation: 1,
                                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(50)),
                                      )
                                  ),
                                  child: Text(
                                    "Save Profile",
                                    style: GoogleFonts.rajdhani(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15,),
                                ElevatedButton(
                                  onPressed: deleteProfile,
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(8, 8),
                                      backgroundColor: const Color.fromRGBO(175, 19, 19, 1.0),
                                      foregroundColor: Colors.white,
                                      elevation: 1,
                                      padding: const EdgeInsets.all(20),
                                      shape: const CircleBorder()
                                  ),
                                  child: Text(
                                    "Delete\nAccount",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.rajdhani(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25
                                    ),
                                  ),
                                )
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        )
    );
  }
}