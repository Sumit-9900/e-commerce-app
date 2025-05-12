import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onChanged;
  final VoidCallback suffixIconPressed;
  const SearchField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.suffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search by Product Title...',
        suffixIcon: IconButton(
          onPressed: suffixIconPressed,
          icon: Icon(Icons.close_outlined),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
