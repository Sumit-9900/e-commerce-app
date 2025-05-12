import 'package:ecommerce_app/features/product-catalog/domain/enums/category.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/price_range.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/rating.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/bloc/products_bloc.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/cubit/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void bottomDraggableFilterSheet(BuildContext context) {
  final filtersCubit = context.read<FilterCubit>();
  final productsCubit = context.read<ProductsBloc>();
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (ctx, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                controller: scrollController,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter Options',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          final filterState = filtersCubit.state;
                          productsCubit.add(
                            ProductsFetched(
                              selectedCategories:
                                  filterState.selectedCategories,
                              selectedPriceRange:
                                  filterState.selectedPriceRange,
                              selectedRating: filterState.selectedRating,
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                        child: Text('Apply'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Category Chips
                  const Text(
                    'Category',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        categoryValues.reverse.values.map((category) {
                          final categoryEnum = categoryValues.map[category]!;
                          return BlocSelector<
                            FilterCubit,
                            FilterState,
                            List<Category>
                          >(
                            selector: (state) {
                              return state.selectedCategories;
                            },
                            builder: (context, selectedCategories) {
                              final isSelected = selectedCategories.contains(
                                categoryEnum,
                              );
                              return ChoiceChip(
                                label: Text(category),
                                selected: isSelected,
                                onSelected: (_) {
                                  filtersCubit.toggleCategory(categoryEnum);
                                },
                                selectedColor: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.2),
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            },
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Price Range Chips
                  const Text(
                    'Price Range',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        priceRangeValues.reverse.values.map((range) {
                          final rangeEnum = priceRangeValues.map[range]!;
                          return BlocSelector<
                            FilterCubit,
                            FilterState,
                            PriceRange?
                          >(
                            selector: (state) {
                              return state.selectedPriceRange;
                            },
                            builder: (context, selectedPriceRange) {
                              final isSelected =
                                  selectedPriceRange == rangeEnum;
                              return ChoiceChip(
                                label: Text(range),
                                selected: isSelected,
                                onSelected: (_) {
                                  filtersCubit.selectPriceRange(rangeEnum);
                                },
                                selectedColor: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.2),
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            },
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Rating Chips
                  const Text(
                    'Rating',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        ratingValues.reverse.values.map((ratingText) {
                          final ratingEnum = ratingValues.map[ratingText]!;

                          return BlocSelector<
                            FilterCubit,
                            FilterState,
                            Rating?
                          >(
                            selector: (state) => state.selectedRating,
                            builder: (context, selectedRating) {
                              final isSelected = selectedRating == ratingEnum;

                              return ChoiceChip(
                                label: Text(ratingText),
                                selected: isSelected,
                                onSelected: (_) {
                                  context.read<FilterCubit>().selectRating(
                                    ratingEnum,
                                  );
                                },
                                selectedColor: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.2),
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            },
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
