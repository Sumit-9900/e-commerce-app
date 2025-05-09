import 'dart:developer';

import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/product-catalog/data/models/product_catalog_model.dart';
import 'package:ecommerce_app/features/product-catalog/domain/usecases/get_all_products.dart';
import 'package:ecommerce_app/init_dependencies.dart';
import 'package:flutter/material.dart';

class ProductCatalogPage extends StatelessWidget {
  const ProductCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = getIt<GetAllProducts>();
    data(NoParams()).then((value) {
      value.fold((l) => log(l.message), (r) {
        final data = ProductCatalogModel.fromEntity(r).toMap();
        log(data.toString());
      });
    });
    return const Scaffold(
      body: Center(child: Text('Welcome to Product Catalog page!')),
    );
  }
}
