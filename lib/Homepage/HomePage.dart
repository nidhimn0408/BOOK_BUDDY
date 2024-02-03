import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Components/BookCard.dart';
import '../Components/BookTile.dart';
import '../Components/MyDrawer.dart';
import '../Controller/BookController.dart';
import '../Models/Data.dart';
import '../BookDetails/BookDetails.dart';
import '../Homepage/Widgets/AppBar.dart';
import '../Homepage/Widgets/CategoryWidget.dart';
import '../Homepage/Widgets/MyInputeTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
final _fs = FirebaseFirestore.instance;
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map<String, dynamic>> getUserData() async {
    try {
      var id = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot res1 = await _fs.collection("users").doc(id).get();

      Map<String, dynamic>? data1 =
          res1.data() as Map<String, dynamic>? ?? {};
      return {
        "user_name": data1['user_name'] ?? "Profile",
        "email": data1['email'] ?? "",
      };
    } catch (e) {
      return {
        'user_name': 'Profile',
        'email': '',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    bookController.getUserBook();
    return Scaffold(
      drawer: myDrawer,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              color: Theme.of(context).colorScheme.primary,
              // height: 500,
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          const HomeAppBar(),
                          const SizedBox(height: 50),
                          Row(
                            children: [
                              Text(
                                "Hello ✌",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize : 28,
                                  color: Theme.of(context).colorScheme.background,
                                ),
                              ),
                              // Use the user's display name dynamically from getUserData
                              FutureBuilder<Map<String, dynamic>>(
                                future: getUserData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    // Display a loading indicator while data is being fetched
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // Handle error case
                                    return Text("Error loading user data");
                                  } else {
                                    // Display user name dynamically
                                    return Text(
                                      " ${snapshot.data?['user_name']}",
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontSize : 28,
                                        color: Theme.of(context).colorScheme.background,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Time to read book and enhance your knowledge",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const MyInputTextField(),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Topics",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .background,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: categoryData
                                  .map(
                                    (e) => CategoryWidget(
                                    iconPath: e["icon"]!,
                                    btnName: e["lebel"]!),
                              )
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Trending",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(
                            () => Row(
                          children: bookController.bookData
                              .map(
                                (e) => BookCard(
                              title: e.title!,
                              coverUrl: e.coverUrl!,
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context){
                                      return BookDetails(
                                        book: e,
                                      );
                                    })
                                );
                              },
                            ),
                          )
                              .toList(),
                        ),
                      )),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Your Interests",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(() => Column(
                    children: bookController.bookData
                        .map(
                          (e) => BookTile(
                        ontap: () {
                          Get.to(BookDetails(book: e));
                        },
                        title: e.title!,
                        coverUrl: e.coverUrl!,
                        author: e.author!,
                        price: e.price!,
                        rating: e.rating!,
                        totalRating: 12,
                      ),
                    )
                        .toList(),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

