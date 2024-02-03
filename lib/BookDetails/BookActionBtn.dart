import '../BookPage/BookPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookActionBtn extends StatefulWidget {
  final String bookUrl;
  const BookActionBtn({super.key, required this.bookUrl});

  @override
  State<BookActionBtn> createState() => _BookActionBtnState();
}

class _BookActionBtnState extends State<BookActionBtn> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context){
              //       return BookPage(
              //         bookUrl: widget.bookUrl,
              //       );
              //     })
              Get.to((BookPage));
              /**/
            },
            child: Row(
              children: [
                SvgPicture.asset("assets/images/book.png"),
                const SizedBox(width: 10),
                Text(
                  "READ BOOK",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.background,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 3,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Row(
            children: [
              SvgPicture.asset("assets/iamges/playe.svg"),
              const SizedBox(width: 10),
              Text(
                "PLAY BOOK",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.background,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

