import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/product_catalog.dart';
import 'package:ecommerce_app/features/product-catalog/domain/usecases/get_all_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetAllProducts _getAllProducts;
  ProductsBloc({required GetAllProducts getAllProducts})
    : _getAllProducts = getAllProducts,
      super(ProductsInitial()) {
    on<ProductsFetched>(_onProductsFetched);
  }

  void _onProductsFetched(
    ProductsFetched event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    final res = await _getAllProducts(NoParams());

    res.fold(
      (l) => emit(ProductsFailure(l.message)),
      (r) => emit(ProductsSuccess(r)),
    );
  }
}
