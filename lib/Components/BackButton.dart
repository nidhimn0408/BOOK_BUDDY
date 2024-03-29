import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MyBackButton extends StatefulWidget {
  const MyBackButton({super.key});

  @override
  State<MyBackButton> createState() => _MyBackButtonState();
}

class _MyBackButtonState extends State<MyBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();

      },
      child: Row(
        children: [
          SvgPicture.asset("assets/images/back.svg"),
          const SizedBox(width: 10),
          Text(
            "Back",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          )
        ],
      ),
    );
  }
}
