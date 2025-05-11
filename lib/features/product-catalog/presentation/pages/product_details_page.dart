import 'package:ecommerce_app/core/utils/bottom_draggable_sheet.dart';
import 'package:ecommerce_app/core/utils/name_to_color.dart';
import 'package:ecommerce_app/core/widgets/add_to_cart_button.dart';
import 'package:ecommerce_app/core/widgets/rating_bar.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/product.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/category.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/color.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/cubit/product_details_cubit.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/widgets/cached_image.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/widgets/review_tile.dart';
import 'package:ecommerce_app/core/widgets/size_color_quantity_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryValues.reverse[product.category].toString()),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedImage(imageUrl: product.images[0], height: 300),
                  const SizedBox(height: 10),
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RatingBar(rating: product.rating),
                  const SizedBox(height: 10),
                  Text(
                    '₹${product.price}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizeColorQuantityTile(
                    text: 'Size',
                    widget: Row(
                      children: [
                        BlocSelector<
                          ProductDetailsCubit,
                          ProductDetailsState,
                          String
                        >(
                          selector: (state) {
                            if (state is ProductDetailsSuccess) {
                              return state.size;
                            } else {
                              return '';
                            }
                          },
                          builder: (context, selectedSize) {
                            return Text(
                              selectedSize,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 14),
                        IconButton(
                          onPressed: () {
                            bottomDraggableSheet(
                              context,
                              headingText: 'Size',
                              variants: product.variants.sizes,
                            );
                          },
                          icon: Icon(Icons.keyboard_arrow_down, size: 35),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizeColorQuantityTile(
                    text: 'Color',
                    widget: Row(
                      children: [
                        BlocSelector<
                          ProductDetailsCubit,
                          ProductDetailsState,
                          String
                        >(
                          selector: (state) {
                            if (state is ProductDetailsSuccess) {
                              return state.color;
                            } else {
                              return '';
                            }
                          },
                          builder: (context, selectedColor) {
                            return CircleAvatar(
                              radius: 15,
                              backgroundColor: getColorFromName(
                                colorValues.map[selectedColor]!,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          onPressed: () {
                            bottomDraggableSheet(
                              context,
                              headingText: 'Color',
                              variants: product.variants.colors,
                            );
                          },
                          icon: Icon(Icons.keyboard_arrow_down, size: 35),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizeColorQuantityTile(
                    text: 'Quantity',
                    widget: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context
                                .read<ProductDetailsCubit>()
                                .incrementQuantity();
                          },
                          icon: Icon(Icons.add),
                          style: IconButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black45,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        BlocSelector<
                          ProductDetailsCubit,
                          ProductDetailsState,
                          int
                        >(
                          selector: (state) {
                            if (state is ProductDetailsSuccess) {
                              return state.quantity;
                            } else {
                              return 1;
                            }
                          },
                          builder: (context, quantity) {
                            return Text(
                              quantity.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            context
                                .read<ProductDetailsCubit>()
                                .decrementQuantity();
                          },
                          icon: Icon(CupertinoIcons.minus),
                          style: IconButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black45,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Product Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 3),
                  BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                    builder: (context, state) {
                      final isMore =
                          state is ProductDetailsSuccess && state.isMore;

                      final description =
                          isMore
                              ? product.description
                              : product.description.substring(
                                0,
                                (product.description.length / 3).floor(),
                              );

                      return RichText(
                        text: TextSpan(
                          text: description,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: isMore ? '...Less' : '...More',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      context
                                          .read<ProductDetailsCubit>()
                                          .toggleMore();
                                    },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${product.rating.toStringAsFixed(1)} Ratings',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${product.reviews.length} Reviews',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  ListView.separated(
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 8),
                    itemCount: product.reviews.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final review = product.reviews[index];
                      return ReviewTile(review: review);
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: AddToCartButton(price: product.price.toStringAsFixed(1)),
          ),
        ],
      ),
    );
  }
}
