part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsFailure extends ProductsState {
  final String message;
  ProductsFailure(this.message);
}

final class ProductsSuccess extends ProductsState {
  final ProductCatalog productCatalog;
  final SortOptions sortOptions;
  final List<Category> selectedCategories;
  final PriceRange? selectedPriceRange;
  final Rating? selectedRating;
  ProductsSuccess(
    this.productCatalog, {
    this.sortOptions = SortOptions.newest,
    this.selectedCategories = const [],
    this.selectedPriceRange,
    this.selectedRating,
  });
}
