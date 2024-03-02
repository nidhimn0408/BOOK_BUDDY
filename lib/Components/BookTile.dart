import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookTile extends StatefulWidget {
  final String title;
  final String coverUrl;
  final String author;
  final int price;
  final String rating;
  final int totalRating;
  final VoidCallback ontap;

  const BookTile({
    super.key,
    required this.title,
    required this.coverUrl,
    required this.author,
    required this.price,
    required this.rating,
    required this.totalRating,
    required this.ontap,
  });

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: widget.ontap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(2, 2),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.coverUrl,
                    width: 100,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text("By : ${widget.author}",
                      style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 5),
                  Text(
                    "Price : ${widget.price}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SvgPicture.asset("Assets/Icons/star.svg"),
                      Text(
                        widget.rating,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "(${widget.totalRating} ratings)",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
