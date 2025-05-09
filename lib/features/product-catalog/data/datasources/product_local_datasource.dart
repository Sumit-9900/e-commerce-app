import 'package:ecommerce_app/core/constants/const.dart';
import 'package:ecommerce_app/features/product-catalog/data/models/product_catalog_model.dart';
import 'package:flutter/services.dart';

abstract interface class ProductLocalDatasource {
  Future<ProductCatalogModel> getProducts();
}

class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  @override
  Future<ProductCatalogModel> getProducts() async {
    try {
      final jsonString = await rootBundle.loadString(Const.productsJson);
      final productsCatalog = ProductCatalogModel.fromJson(jsonString);
      return productsCatalog;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
