part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartFailure extends CartState {
  final String message;
  const CartFailure(this.message);
}

final class CartSuccess extends CartState {
  final List<Cart> cartProducts;
  const CartSuccess(this.cartProducts);
}

final class CartSuccessForAllProductsDeletion extends CartState {}
