import 'package:ecommerce_app/core/widgets/rating_bar.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/review.dart';
import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  final Review review;
  final bool isTablet;
  const ReviewTile({super.key, required this.review, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                RatingBar(rating: review.rating.toDouble()),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              review.comment,
              style: TextStyle(
                fontSize: isTablet ? 18 : 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff272727),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
