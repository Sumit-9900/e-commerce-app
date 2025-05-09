import 'package:ecommerce_app/features/product-catalog/domain/entities/review.dart';

class ReviewModel {
  final String name;
  final int rating;
  final String comment;

  ReviewModel({
    required this.name,
    required this.rating,
    required this.comment,
  });

  // Convert to domain entity
  Review toEntity() => Review(name: name, rating: rating, comment: comment);

  // Convert from domain entity
  factory ReviewModel.fromEntity(Review review) => ReviewModel(
    name: review.name,
    rating: review.rating,
    comment: review.comment,
  );

  // Serialization
  Map<String, dynamic> toMap() => {
    'name': name,
    'rating': rating,
    'comment': comment,
  };

  factory ReviewModel.fromMap(Map<String, dynamic> map) => ReviewModel(
    name: map['name'] ?? '',
    rating: map['rating'] ?? '',
    comment: map['comment'] ?? '',
  );

  @override
  String toString() =>
      'ReviewModel(name: $name, rating: $rating, comment: $comment)';
}
