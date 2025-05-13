import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/widgets/loader.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/cubit/add_product_to_cart_cubit.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final String price;
  final AddProductToCartState state;
  const AddToCartButton({super.key, required this.price, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.purpleColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child:
          state is AddProductToCartLoading
              ? const Loader()
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹$price',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Add to Bag',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
