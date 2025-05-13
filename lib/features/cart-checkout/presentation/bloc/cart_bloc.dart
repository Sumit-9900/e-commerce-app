import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/decrement_cart_quantity.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/delete_all_cart_products.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/get_cart_items.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/increment_cart_quantity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItems _getCartItems;
  final DeleteAllCartProducts _deleteAllCartProducts;
  final DecrementCartQuantity _decrementCartQuantity;
  final IncrementCartQuantity _incrementCartQuantity;
  CartBloc({
    required GetCartItems getCartItems,
    required DeleteAllCartProducts deleteAllCartProducts,
    required DecrementCartQuantity decrementCartQuantity,
    required IncrementCartQuantity incrementCartQuantity,
  }) : _getCartItems = getCartItems,
       _deleteAllCartProducts = deleteAllCartProducts,
       _decrementCartQuantity = decrementCartQuantity,
       _incrementCartQuantity = incrementCartQuantity,
       super(CartInitial()) {
    on(_onCartProductsFetched);
    on(_onCartProductsDeleted);
    on(_onCartProductDecremented);
    on(_onCartProductIncremented);
  }

  void _onCartProductsFetched(
    CartProductsFetched event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());

    final res = await _getCartItems(NoParams());

    res.fold((l) => emit(CartFailure(l.message)), (r) => emit(CartSuccess(r)));
  }

  void _onCartProductsDeleted(
    CartProductsDeleted event,
    Emitter<CartState> emit,
  ) async {
    final res = await _deleteAllCartProducts(NoParams());

    res.fold((l) => emit(CartFailure(l.message)), (r) {
      emit(CartSuccessForAllProductsDeletion());
      add(CartProductsFetched());
    });
  }

  void _onCartProductDecremented(
    CartProductQuantityDecremented event,
    Emitter<CartState> emit,
  ) async {
    final res = await _decrementCartQuantity(event.id);

    res.fold(
      (l) => emit(CartFailure(l.message)),
      (r) => add(CartProductsFetched()),
    );
  }

  void _onCartProductIncremented(
    CartProductQuantityIncremented event,
    Emitter<CartState> emit,
  ) async {
    final res = await _incrementCartQuantity(event.id);

    res.fold(
      (l) => emit(CartFailure(l.message)),
      (r) => add(CartProductsFetched()),
    );
  }
}
