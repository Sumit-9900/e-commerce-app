import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/widgets/common_tile.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/sort_options.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void bottomDraggableSortSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.1,
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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Sort Options',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: 4,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final sortOptions =
                            sortOptionsValues.reverse.values.toList();
                        return GestureDetector(
                          onTap: () {
                            context.read<ProductsBloc>().add(
                              ProductsFetched(
                                sortOptions:
                                    sortOptionsValues.map[sortOptions[index]] ??
                                    SortOptions.newest,
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child:
                              BlocSelector<ProductsBloc, ProductsState, String>(
                                selector: (state) {
                                  if (state is ProductsSuccess) {
                                    final selectedSortOptions =
                                        sortOptionsValues.reverse[state
                                            .sortOptions];
                                    return selectedSortOptions!;
                                  } else {
                                    return '';
                                  }
                                },
                                builder: (context, sortOption) {
                                  final selectedOptions =
                                      sortOptions[index] == sortOption;

                                  return CommonTile(
                                    text: sortOptions[index],
                                    widget:
                                        selectedOptions
                                            ? const Icon(Icons.done)
                                            : const SizedBox(),
                                    color:
                                        selectedOptions
                                            ? AppColors.purpleColor
                                            : AppColors.tileColor,
                                  );
                                },
                              ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
