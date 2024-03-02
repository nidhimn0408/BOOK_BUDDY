import '../Config/Colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String btnName;
  final VoidCallback ontap;
  const PrimaryButton({super.key, required this.btnName, required this.ontap});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Container(
        height: 55,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: backgroudColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset("Assets/Icons/google.png"),
            ),
            const SizedBox(width: 10),
            Text(
              widget.btnName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.background,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
