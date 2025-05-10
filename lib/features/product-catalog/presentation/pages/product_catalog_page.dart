import 'dart:developer';

import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/core/utils/show_snackbar.dart';
import 'package:ecommerce_app/core/widgets/loader.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/bloc/products_bloc.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/widgets/product_tile.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/widgets/search_field.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/widgets/sort_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class ProductCatalogPage extends StatefulWidget {
  const ProductCatalogPage({super.key});

  @override
  State<ProductCatalogPage> createState() => _ProductCatalogPageState();
}

class _ProductCatalogPageState extends State<ProductCatalogPage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Men\'s Clothing')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SearchField(controller: searchController),
              const SizedBox(height: 12),
              BlocConsumer<ProductsBloc, ProductsState>(
                listener: (context, state) {
                  if (state is ProductsFailure) {
                    showSnackBar(
                      context,
                      message: state.message,
                      color: Colors.red,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return Expanded(child: Loader());
                  } else if (state is ProductsSuccess) {
                    final products = state.productCatalog.products;
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${products.length} Items',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  SortFilterButton(
                                    text: 'Sort',
                                    icon: Icons.sort_rounded,
                                    onPressed: () {},
                                  ),
                                  const SizedBox(width: 10),
                                  SortFilterButton(
                                    text: 'Filter',
                                    icon: Icons.filter_alt,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: MasonryGridView.builder(
                              gridDelegate:
                                  SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final isLarge =
                                    (index % 4 == 1 || index % 4 == 2);
                                final product = products[index];

                                log('color: ${product.variants.colors}');

                                return GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                      AppRouterConstants.productDetailsRoute,
                                      pathParameters: {
                                        'id': product.id.toString(),
                                      },
                                      extra: product,
                                    );
                                  },
                                  child: ProductTile(
                                    isLarge: isLarge,
                                    product: product,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
