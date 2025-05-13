import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/product_catalog.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/category.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/price_range.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/rating.dart';
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
    on<ProductsSearched>(_onProductsSearched);
  }

  void _onProductsFetched(
    ProductsFetched event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    final res = await _getAllProducts(NoParams());

    res.fold((l) => emit(ProductsFailure(l.message)), (r) {
      final filterredProducts = _filterProducts(
        r,
        event.selectedCategories,
        event.selectedPriceRange,
        event.selectedRating,
      );

      final sortedProducts = _sortProducts(
        filterredProducts,
        event.sortOptions,
      );
      emit(
        ProductsSuccess(
          sortedProducts,
          sortOptions: event.sortOptions,
          selectedCategories: event.selectedCategories,
          selectedPriceRange: event.selectedPriceRange,
          selectedRating: event.selectedRating,
        ),
      );
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

  ProductCatalog _filterProducts(
    ProductCatalog catalog,
    List<Category> selectedCategories,
    PriceRange? priceRange,
    Rating? rating,
  ) {
    var filterredProducts = catalog.products;

    if (selectedCategories.isNotEmpty) {
      filterredProducts =
          filterredProducts
              .where((product) => selectedCategories.contains(product.category))
              .toList();
    }

    if (priceRange != null) {
      switch (priceRange) {
        case PriceRange.under500:
          filterredProducts =
              filterredProducts.where((produt) => produt.price < 500).toList();
          break;
        case PriceRange.from500To1000:
          filterredProducts =
              filterredProducts
                  .where(
                    (product) => product.price >= 500 && product.price <= 1000,
                  )
                  .toList();
          break;
        case PriceRange.from1000To2000:
          filterredProducts =
              filterredProducts
                  .where(
                    (product) => product.price >= 1000 && product.price <= 2000,
                  )
                  .toList();
          break;
        case PriceRange.above2000:
          filterredProducts =
              filterredProducts
                  .where((product) => product.price > 2000)
                  .toList();
          break;
      }
    }

    if (rating != null) {
      switch (rating) {
        case Rating.above4Star:
          filterredProducts =
              filterredProducts
                  .where((product) => product.rating >= 4.0)
                  .toList();
          break;
        case Rating.above3Star:
          filterredProducts =
              filterredProducts
                  .where((product) => product.rating >= 3.0)
                  .toList();
          break;
        case Rating.above2Star:
          filterredProducts =
              filterredProducts
                  .where((product) => product.rating >= 2.0)
                  .toList();
          break;
      }
    }

    return ProductCatalog(
      products: filterredProducts,
      total: filterredProducts.length,
      categories: catalog.categories,
    );
  }

  void _onProductsSearched(
    ProductsSearched event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    final res = await _getAllProducts(NoParams());

    res.fold((l) => emit(ProductsFailure(l.message)), (r) {
      final searchProducts =
          r.products
              .where(
                (product) => product.name.trim().toLowerCase().contains(
                  event.query.trim().toLowerCase(),
                ),
              )
              .toList();

      emit(
        ProductsSuccess(
          ProductCatalog(
            products: searchProducts,
            total: searchProducts.length,
            categories: r.categories,
          ),
        ),
      );
    });
  }
}
