import 'package:ecommerce_app/features/product-catalog/domain/enums/category.dart';

import 'review.dart';
import 'variants.dart';

class Product {
  int id;
  String name;
  Category category;
  int price;
  List<String> images;
  String description;
  Variants variants;
  double rating;
  List<Review> reviews;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.images,
    required this.description,
    required this.variants,
    required this.rating,
    required this.reviews,
  });
}
