import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final bool isTablet;
  const SectionTitle({super.key, required this.title, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: isTablet ? 24 : 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
