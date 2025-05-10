import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/product.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/pages/product_catalog_page.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
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
          final product = state.extra as Product;
          return ProductDetailsPage(product: product);
        },
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(body: Center(child: Text('Error Page!')));
    },
  );
}
