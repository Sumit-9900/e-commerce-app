import 'package:flutter/material.dart';

class SizeColorQuantityTile extends StatelessWidget {
  final String text;
  final Widget widget;
  const SizeColorQuantityTile({super.key, required this.text, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color.fromARGB(78, 158, 158, 158),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            widget,
          ],
        ),
      ),
    );
  }
}
