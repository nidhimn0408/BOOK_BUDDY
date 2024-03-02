import '../Config/Colors.dart';
import '../Models/BookModel.dart';
import '../BookDetails/BookActionBtn.dart';
import '../BookDetails/HeaderWidget.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  final BookModel book;
  const BookDetails({super.key, required this.book});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xCB664FA4),
              child: Row(
                children: [
                  Expanded(
                    child: BookDetailsHeader(
                      coverUrl: widget.book.coverUrl!,
                      title: widget.book.title!,
                      author: widget.book.author!,
                      description: widget.book.description!,
                      rating: widget.book.rating!,
                      pages: widget.book.pages.toString(),
                      langugae: widget.book.language.toString(),
                      audioLen: widget.book.audioLen!,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "About book",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.book.description!,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "About Author",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.book.aboutAuthor!,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  BookActionBtn(
                    bookUrl: widget.book.bookurl!,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
