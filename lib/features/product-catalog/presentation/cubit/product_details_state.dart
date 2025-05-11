part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsSuccess extends ProductDetailsState {
  final String size;
  final String color;
  final int quantity;
  final bool isMore;
  ProductDetailsSuccess({
    required this.size,
    required this.color,
    required this.quantity,
    required this.isMore,
  });

  ProductDetailsSuccess copyWith({
    String? size,
    String? color,
    int? quantity,
    bool? isMore,
  }) {
    return ProductDetailsSuccess(
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      isMore: isMore ?? this.isMore,
    );
  }
}
