import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CheckoutItemTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String size;
  final String color;
  final double price;
  final String quantity;

  const CheckoutItemTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.size,
    required this.color,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xfff6f6f6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 80,
                width: 70,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) =>
                        Container(height: 80, width: 70, color: Colors.grey),
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey,
                      child: const Icon(Icons.error),
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Size - $size    Color - $color',
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${price.toStringAsFixed(1)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xfff0e6ff),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Qty: $quantity',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
