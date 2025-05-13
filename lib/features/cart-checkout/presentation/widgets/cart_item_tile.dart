import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/constants/const.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemTile extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  final String size;
  final String color;
  final double price;
  final String quantity;

  const CartItemTile({
    super.key,
    required this.id,
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
                    (context, url, error) =>
                        Container(color: Colors.grey, child: Icon(Icons.error)),
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
                    '${Const.indianRuppee}${price.toStringAsFixed(1)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _circleButton(Icons.remove, () {
                  context.read<CartBloc>().add(
                    CartProductQuantityDecremented(id),
                  );
                }),
                const SizedBox(width: 8),
                Text(quantity, style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                _circleButton(Icons.add, () {
                  context.read<CartBloc>().add(
                    CartProductQuantityIncremented(id),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff0e6ff),
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18),
        color: Colors.deepPurple,
        onPressed: onTap,
      ),
    );
  }
}
