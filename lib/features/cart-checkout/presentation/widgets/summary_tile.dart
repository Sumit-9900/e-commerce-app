import 'package:flutter/material.dart';

class SummaryTile extends StatelessWidget {
  final String title;
  final String value;
  final bool isTablet;
  final bool isTotal;
  const SummaryTile({
    super.key,
    required this.title,
    required this.value,
    required this.isTablet,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTablet ? 22 : 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTablet ? 22 : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
