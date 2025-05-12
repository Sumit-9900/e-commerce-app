part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

final class ProductsFetched extends ProductsEvent {
  final SortOptions sortOptions;
  ProductsFetched({this.sortOptions = SortOptions.newest});
}
