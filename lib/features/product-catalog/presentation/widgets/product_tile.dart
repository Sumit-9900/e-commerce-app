import 'package:ecommerce_app/core/constants/const.dart';
import 'package:ecommerce_app/core/widgets/rating_bar.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/product.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/widgets/cached_image.dart';
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
            CachedImage(
              imageUrl: product.images[0],
              height: isLarge ? 190 : 130,
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
                    '${Const.indianRuppee}${product.price}',
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
