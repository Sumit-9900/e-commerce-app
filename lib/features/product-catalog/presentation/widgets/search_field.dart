import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  const SearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search any Product...',
      ),
    );
  }
}
