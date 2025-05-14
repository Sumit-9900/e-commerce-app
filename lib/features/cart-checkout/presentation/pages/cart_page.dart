import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/core/utils/device_utils.dart';
import 'package:ecommerce_app/core/utils/show_snackbar.dart';
import 'package:ecommerce_app/core/widgets/loader.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/cart_checkout_button.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/cart_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceUtils.isTablet(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(CartProductsDeleted());
            },
            child: Text(
              'Remove All',
              style: TextStyle(
                fontSize: isTablet ? 22 : 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartFailure) {
            showSnackBar(context, message: state.message, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return const Loader();
          } else if (state is CartSuccess) {
            if (state.cartProducts.isEmpty) {
              return Center(
                child: Text(
                  'No Cart Products to display!',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet ? 22 : 18,
                    color: Colors.black,
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cartProducts.length,
                      itemBuilder: (context, index) {
                        final product = state.cartProducts[index];
                        return CartItemTile(
                          id: product.id,
                          imageUrl: product.image,
                          title: product.title,
                          price: product.price.toDouble(),
                          size: product.size,
                          color: product.color,
                          quantity: product.quantity.toString(),
                          isTablet: isTablet,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  CartCheckoutButton(
                    isTablet: isTablet,
                    label: 'Checkout',
                    onPressed: () {
                      context.pushNamed(
                        AppRouterConstants.productCheckoutRoute,
                        extra: state.cartProducts,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
