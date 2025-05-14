import 'package:ecommerce_app/features/product-catalog/domain/enums/category.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/price_range.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/rating.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState());

  void toggleCategory(Category category) {
    final updated = [...state.selectedCategories];
    updated.contains(category)
        ? updated.remove(category)
        : updated.add(category);
    emit(state.copyWith(selectedCategories: updated));
  }

  void selectPriceRange(PriceRange range) {
    final newValue = state.selectedPriceRange == range ? null : range;
    emit(state.copyWith(selectedPriceRange: newValue));
  }

  void selectRating(Rating rating) {
    final newValue = state.selectedRating == rating ? null : rating;
    emit(state.copyWith(selectedRating: newValue));
  }

  void clearFilters() {
    emit(const FilterState());
  }
}
