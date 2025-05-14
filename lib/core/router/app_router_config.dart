import 'package:ecommerce_app/core/animations/page_transitions.dart';
import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/pages/cart_page.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/pages/checkout_page.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/pages/order_confirmation_page.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/pages/payment_page.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/pages/shipping_page.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/product.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/color.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/size.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/cubit/product_details_cubit.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/pages/product_catalog_page.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/pages/product_details_page.dart';
import 'package:ecommerce_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouterConfig {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRouterConstants.productCatalogRoute,
        builder: (context, state) => const ProductCatalogPage(),
      ),
      GoRoute(
        path: '/product/:id',
        name: AppRouterConstants.productDetailsRoute,
        builder: (context, state) {
          final product = state.extra! as Product;
          final initialSize = sizeValues.reverse[product.variants.sizes.first]!;
          final initialColor =
              colorValues.reverse[product.variants.colors.first];
          return BlocProvider(
            create:
                (_) => getIt<ProductDetailsCubit>(
                  param1: initialSize,
                  param2: initialColor,
                ),
            child: ProductDetailsPage(product: product),
          );
        },
      ),
      GoRoute(
        path: '/cart',
        name: AppRouterConstants.productCartRoute,
        pageBuilder:
            (context, state) =>
                buildFadeTransitionPage(state: state, child: const CartPage()),
      ),
      GoRoute(
        path: '/checkout',
        name: AppRouterConstants.productCheckoutRoute,
        pageBuilder: (context, state) {
          final cartProducts = state.extra as List<Cart>;
          return buildSlideTransitionPage(
            state: state,
            child: CheckoutPage(cartProducts: cartProducts),
          );
        },
      ),
      GoRoute(
        path: '/checkout/shipping',
        name: AppRouterConstants.productShippingRoute,
        pageBuilder:
            (context, state) => buildSlideTransitionPage(
              state: state,
              child: const ShippingPage(),
            ),
      ),
      GoRoute(
        path: '/checkout/payment',
        name: AppRouterConstants.productPaymentRoute,
        pageBuilder:
            (context, state) => buildSlideTransitionPage(
              state: state,
              child: const PaymentPage(),
            ),
      ),
      GoRoute(
        path: '/checkout/confirm',
        name: AppRouterConstants.productConfirmationRoute,
        pageBuilder:
            (context, state) => buildSlideTransitionPage(
              state: state,
              child: const OrderConfirmationPage(),
            ),
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(body: Center(child: Text('Error Page!')));
    },
  );
}
