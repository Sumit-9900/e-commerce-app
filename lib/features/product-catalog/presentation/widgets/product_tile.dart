import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/widgets/rating_bar.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final bool isLarge;
  final Product product;
  const ProductTile({super.key, required this.isLarge, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        height: isLarge ? 310 : 250,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: product.images[0],
                fit: BoxFit.cover,
                height: isLarge ? 190 : 130,
                width: double.infinity,
                placeholder: (context, url) => Container(color: Colors.grey),
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Icon(Icons.error, color: Colors.red),
                          const SizedBox(height: 3),
                          Text('Unable to fetch data!'),
                        ],
                      ),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '₹${product.price}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 3),
                  RatingBar(rating: product.rating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
