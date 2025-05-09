import 'dart:convert';

import 'package:ecommerce_app/features/product-catalog/domain/entities/product.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/category.dart';

import 'review_model.dart';
import 'variants_model.dart';

class ProductModel {
  final int id;
  final String name;
  final Category category;
  final int price;
  final List<String> images;
  final String description;
  final VariantsModel variants;
  final double rating;
  final List<ReviewModel> reviews;

  ProductModel({
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

  /// Converts this model into a domain entity
  Product toEntity() => Product(
    id: id,
    name: name,
    category: category,
    price: price,
    images: images,
    description: description,
    variants: variants.toEntity(),
    rating: rating,
    reviews: reviews.map((e) => e.toEntity()).toList(),
  );

  /// Converts a domain entity back into a model (if needed)
  factory ProductModel.fromEntity(Product product) => ProductModel(
    id: product.id,
    name: product.name,
    category: product.category,
    price: product.price,
    images: product.images,
    description: product.description,
    variants: VariantsModel.fromEntity(product.variants),
    rating: product.rating,
    reviews: product.reviews.map((e) => ReviewModel.fromEntity(e)).toList(),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'category': category.name,
    'price': price,
    'images': images,
    'description': description,
    'variants': variants.toMap(),
    'rating': rating,
    'reviews': reviews.map((e) => e.toMap()).toList(),
  };

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
    id: map['id'],
    name: map['name'],
    category: Category.values.firstWhere(
      (e) => e.name.toLowerCase() == map['category'].toLowerCase(),
      orElse: () => Category.T_SHIRTS,
    ),
    price: map['price'],
    images: List<String>.from(map['images']),
    description: map['description'],
    variants: VariantsModel.fromMap(map['variants']),
    rating: map['rating'].toDouble(),
    reviews: List<ReviewModel>.from(
      map['reviews'].map((x) => ReviewModel.fromMap(x)),
    ),
  );

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
