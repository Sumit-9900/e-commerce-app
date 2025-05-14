import 'package:flutter/material.dart';

class CartCheckoutButton extends StatelessWidget {
  final bool isTablet;
  final String label;
  final VoidCallback onPressed;
  const CartCheckoutButton({
    super.key,
    required this.isTablet,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: isTablet ? 60 : 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 24 : 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
