import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/product_catalog.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/sort_options.dart';
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

    res.fold((l) => emit(ProductsFailure(l.message)), (r) {
      final sortedProducts = _sortProducts(r, event.sortOptions);
      emit(ProductsSuccess(sortedProducts, sortOptions: event.sortOptions));
    });
  }

  ProductCatalog _sortProducts(ProductCatalog catalog, SortOptions sortOption) {
    final products = catalog.products;

    switch (sortOption) {
      case SortOptions.priceHighToLow:
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOptions.priceLowToHigh:
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOptions.popularity:
        products.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortOptions.newest:
        break;
    }

    return ProductCatalog(
      products: products,
      total: products.length,
      categories: catalog.categories,
    );
  }
}
