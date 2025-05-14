import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isObscured;
  final bool isTablet;
  const InputField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.name,
    this.isObscured = false,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isObscured,
        style: TextStyle(fontSize: isTablet ? 24 : 18),
        validator: (value) {
          if (value!.trim().isEmpty) {
            return '$label is missing!';
          } else if (label == 'Phone Number' && value.trim().length != 10) {
            return '$label should be 10 characters!';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(fontSize: isTablet ? 24 : 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
