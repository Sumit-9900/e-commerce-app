import 'package:ecommerce_app/features/cart-checkout/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/add_to_cart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_product_to_cart_state.dart';

class AddProductToCartCubit extends Cubit<AddProductToCartState> {
  final AddToCart _addToCart;
  final CartBloc _cartBloc;
  AddProductToCartCubit({
    required AddToCart addToCart,
    required CartBloc cartBloc,
  }) : _addToCart = addToCart,
       _cartBloc = cartBloc,
       super(AddProductToCartInitial());

  void addProductToCart(Cart cart) async {
    emit(AddProductToCartLoading());

    final res = await _addToCart(cart);

    res.fold((l) => emit(AddProductToCartFailure(l.toString())), (r) {
      emit(AddProductToCartSuccess());
      _cartBloc.add(CartProductsFetched());
    });
  }
}
