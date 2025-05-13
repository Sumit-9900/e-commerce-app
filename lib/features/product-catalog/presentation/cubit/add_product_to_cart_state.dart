part of 'add_product_to_cart_cubit.dart';

sealed class AddProductToCartState extends Equatable {
  const AddProductToCartState();

  @override
  List<Object> get props => [];
}

final class AddProductToCartInitial extends AddProductToCartState {}

final class AddProductToCartLoading extends AddProductToCartState {}

final class AddProductToCartFailure extends AddProductToCartState {
  final String message;
  const AddProductToCartFailure(this.message);
}

final class AddProductToCartSuccess extends AddProductToCartState {}
