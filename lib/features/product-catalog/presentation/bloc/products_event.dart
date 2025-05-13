part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

final class ProductsFetched extends ProductsEvent {
  final SortOptions sortOptions;
  final List<Category> selectedCategories;
  final PriceRange? selectedPriceRange;
  final Rating? selectedRating;
  ProductsFetched({
    this.sortOptions = SortOptions.newest,
    this.selectedCategories = const [],
    this.selectedPriceRange,
    this.selectedRating,
  });
}

final class ProductsSearched extends ProductsEvent {
  final String query;
  ProductsSearched(this.query);
}
