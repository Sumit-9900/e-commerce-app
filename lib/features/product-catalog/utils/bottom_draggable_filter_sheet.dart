import 'package:flutter/material.dart';

void bottomDraggableFilterSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (ctx, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Text(
                      'Filter Options',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Category Chips
                  const Text(
                    'Category',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        [
                          'T-Shirts',
                          'Shirts',
                          'Jeans',
                          'Trousers',
                          'Sweatshirts',
                        ].map((category) {
                          return ChoiceChip(
                            label: Text(category),
                            selected: false, // Hook with Bloc or local state
                            onSelected: (_) => Navigator.pop(context),
                            selectedColor: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.2),
                            labelStyle: const TextStyle(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Price Range Chips
                  const Text(
                    'Price Range',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        [
                          'Under ₹500',
                          '₹500 - ₹1000',
                          '₹1000 - ₹2000',
                          'Above ₹2000',
                        ].map((range) {
                          return ChoiceChip(
                            label: Text(range),
                            selected: false, // Replace with your logic
                            onSelected: (_) => Navigator.pop(context),
                            selectedColor: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.2),
                            labelStyle: const TextStyle(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Rating Chips
                  const Text(
                    'Rating',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        ['4★ & above', '3★ & above', '2★ & above'].map((
                          rating,
                        ) {
                          return ChoiceChip(
                            label: Text(rating),
                            selected: false, // Replace with Bloc state
                            onSelected: (_) => Navigator.pop(context),
                            selectedColor: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.2),
                            labelStyle: const TextStyle(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
