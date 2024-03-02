import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../BookDetails/BookDetails.dart';
import '../Components/BookTile.dart';
import '../Components/MyDrawer.dart';
import '../Controller/BookController.dart';

class CurrentlyReading extends StatelessWidget {
  const CurrentlyReading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    bookController.getUserBook();

    return Scaffold(
      drawer: myDrawer, // Assuming MyDrawer is a widget
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // "Your Interests" centered at the top
                  Text(
                    "Your Interests",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 10),
                  Obx(
                        () => Column(
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
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


