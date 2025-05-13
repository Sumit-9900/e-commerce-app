part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class CartProductsFetched extends CartEvent {}

final class CartProductsDeleted extends CartEvent {}

final class CartProductQuantityDecremented extends CartEvent {
  final String id;
  const CartProductQuantityDecremented(this.id);
}

final class CartProductQuantityIncremented extends CartEvent {
  final String id;
  const CartProductQuantityIncremented(this.id);
}
