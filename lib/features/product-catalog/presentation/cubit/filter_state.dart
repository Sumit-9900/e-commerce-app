part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final List<Category> selectedCategories;
  final PriceRange? selectedPriceRange;
  final Rating? selectedRating;

  const FilterState({
    this.selectedCategories = const [],
    this.selectedPriceRange,
    this.selectedRating,
  });

  FilterState copyWith({
    List<Category>? selectedCategories,
    PriceRange? selectedPriceRange,
    Rating? selectedRating,
  }) {
    return FilterState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedPriceRange: selectedPriceRange ?? this.selectedPriceRange,
      selectedRating: selectedRating ?? this.selectedRating,
    );
  }

  @override
  List<Object?> get props => [
    selectedCategories,
    selectedPriceRange,
    selectedRating,
  ];
}
