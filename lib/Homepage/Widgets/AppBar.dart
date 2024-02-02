import 'package:velocity_x/velocity_x.dart';

import '../../Navigator/profile/account.dart';
import '../../Navigator/profile/profile.dart';
//import 'package:e_book/Controller/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthController authController = Get.put(AuthController());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: SvgPicture.asset("assets/images/dashboard.svg")),
        Text(
          "E-BOOK",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Account()),
            );
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.background,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Icon(
                Icons.account_circle, // Replace with your desired profile icon
                size: 40,
                color: Vx.purple600, // Adjust the color as needed
              ),
            ),
          ),
        )


      ],
    );
  }
}
