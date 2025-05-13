import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/core/utils/show_snackbar.dart';
import 'package:ecommerce_app/core/widgets/loader.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/cart_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(CartProductsDeleted());
            },
            child: const Text(
              'Remove All',
              style: TextStyle(fontSize: 16, color: Colors.black),
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
              return const Center(
                child: Text(
                  'No Cart Products to display!',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
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
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        context.pushNamed(
                          AppRouterConstants.productCheckoutRoute,
                          extra: state.cartProducts,
                        );
                      }, // checkout
                      child: const Text(
                        'Checkout',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
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
