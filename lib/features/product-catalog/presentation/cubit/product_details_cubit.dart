import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit({
    required String initialSize,
    required String initialColor,
    int initialQuantity = 1,
    bool isMore = false,
  }) : super(
         ProductDetailsSuccess(
           size: initialSize,
           color: initialColor,
           quantity: initialQuantity,
           isMore: isMore,
         ),
       );

  void changeSize(String selectedSize) {
    final currentState = state;
    if (currentState is ProductDetailsSuccess) {
      emit(currentState.copyWith(size: selectedSize));
    }
  }

  void changeColor(String newColor) {
    final currentState = state;
    if (currentState is ProductDetailsSuccess) {
      emit(currentState.copyWith(color: newColor));
    }
  }

  void incrementQuantity() {
    final currentState = state;
    if (currentState is ProductDetailsSuccess) {
      final updatedQuantity = currentState.quantity + 1;
      emit(currentState.copyWith(quantity: updatedQuantity));
    }
  }

  void decrementQuantity() {
    final currentState = state;
    if (currentState is ProductDetailsSuccess) {
      final updatedQuantity = currentState.quantity - 1;
      if (updatedQuantity < 1) {
        return;
      }
      emit(currentState.copyWith(quantity: updatedQuantity));
    }
  }

  void toggleMore() {
    final currentState = state;
    if (currentState is ProductDetailsSuccess) {
      emit(currentState.copyWith(isMore: !currentState.isMore));
    }
  }
}
