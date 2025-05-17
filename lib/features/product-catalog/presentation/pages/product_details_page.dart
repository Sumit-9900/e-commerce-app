import 'package:ecommerce_app/core/constants/const.dart';
import 'package:ecommerce_app/core/utils/bottom_draggable_sheet.dart';
import 'package:ecommerce_app/core/utils/device_utils.dart';
import 'package:ecommerce_app/core/utils/name_to_color.dart';
import 'package:ecommerce_app/core/utils/show_snackbar.dart';
import 'package:ecommerce_app/core/widgets/add_to_cart_button.dart';
import 'package:ecommerce_app/core/widgets/rating_bar.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/product.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/category.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/color.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/cubit/add_product_to_cart_cubit.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/cubit/product_details_cubit.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/widgets/cached_image.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/widgets/review_tile.dart';
import 'package:ecommerce_app/core/widgets/common_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceUtils.isTablet(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryValues.reverse[product.category].toString()),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddProductToCartCubit, AddProductToCartState>(
          listener: (context, state) {
            if (state is AddProductToCartFailure) {
              showSnackBar(context, message: state.message, color: Colors.red);
            } else if (state is AddProductToCartSuccess) {
              showSnackBar(
                context,
                message: 'Product has been added to the Cart!',
                color: Colors.green,
              );
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                final state = context.read<ProductDetailsCubit>().state;
                int quantity = 1;
                String color = '';
                String size = '';
                if (state is ProductDetailsSuccess) {
                  quantity = state.quantity;
                  color = state.color;
                  size = state.size;
                }

                final cart = Cart(
                  id: product.id.toString(),
                  title: product.name,
                  price: product.price,
                  quantity: quantity,
                  color: color,
                  size: size,
                  image: product.images[0],
                );

                context.read<AddProductToCartCubit>().addProductToCart(cart);
              },
              child: AddToCartButton(
                price: product.price.toStringAsFixed(1),
                state: state,
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocSelector<ProductDetailsCubit, ProductDetailsState, String>(
                selector: (state) {
                  if (state is ProductDetailsSuccess) {
                    return state.image;
                  } else {
                    return product.images[0];
                  }
                },
                builder: (context, selectedImage) {
                  return Hero(
                    tag: product.id,
                    child: CachedImage(imageUrl: selectedImage, height: 300),
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isTablet ? 24 : 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              RatingBar(rating: product.rating),
              const SizedBox(height: 10),
              Text(
                '${Const.indianRuppee}${product.price}',
                style: TextStyle(
                  fontSize: isTablet ? 22 : 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              CommonTile(
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
                          product: product,
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
              CommonTile(
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
                          product: product,
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
              CommonTile(
                text: 'Quantity',
                widget: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<ProductDetailsCubit>().incrementQuantity();
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
                    BlocSelector<ProductDetailsCubit, ProductDetailsState, int>(
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
                        context.read<ProductDetailsCubit>().decrementQuantity();
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
                  fontSize: isTablet ? 24 : 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 3),
              BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                builder: (context, state) {
                  final isMore = state is ProductDetailsSuccess && state.isMore;

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
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 14,
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: isMore ? '...Less' : '...More',
                          style: TextStyle(
                            fontSize: isTablet ? 18 : 14,
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
                  fontSize: isTablet ? 22 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${product.rating.toStringAsFixed(1)} Ratings',
                style: TextStyle(
                  fontSize: isTablet ? 26 : 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${product.reviews.length} Reviews',
                style: TextStyle(
                  fontSize: isTablet ? 20 : 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: product.reviews.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final review = product.reviews[index];
                  return ReviewTile(review: review, isTablet: isTablet);
                },
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
