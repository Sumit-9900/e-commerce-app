import 'package:flutter/material.dart';

class SortFilterButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  const SortFilterButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
      icon: Icon(icon),
    );
  }
}
