import 'dart:convert';

import 'package:ecommerce_app/features/product-catalog/domain/entities/product_catalog.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/category.dart';
import 'package:flutter/foundation.dart';

import 'package:ecommerce_app/features/product-catalog/data/models/product_model.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/category.dart'
    as c;

class ProductCatalogModel {
  List<ProductModel> products;
  int total;
  List<c.Category> categories;

  ProductCatalogModel({
    required this.products,
    required this.total,
    required this.categories,
  });

  ProductCatalogModel copyWith({
    List<ProductModel>? products,
    int? total,
    List<c.Category>? categories,
  }) {
    return ProductCatalogModel(
      products: products ?? this.products,
      total: total ?? this.total,
      categories: categories ?? this.categories,
    );
  }

  ProductCatalog toEntity() => ProductCatalog(
    products: products.map((product) => product.toEntity()).toList(),
    total: total,
    categories: categories,
  );

  factory ProductCatalogModel.fromEntity(ProductCatalog productCatalog) =>
      ProductCatalogModel(
        products:
            productCatalog.products
                .map((product) => ProductModel.fromEntity(product))
                .toList(),
        total: productCatalog.total,
        categories: productCatalog.categories,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
      'total': total,
      'categories': List<dynamic>.from(
        categories.map((x) => categoryValues.reverse[x]),
      ),
    };
  }

  factory ProductCatalogModel.fromMap(Map<String, dynamic> map) {
    return ProductCatalogModel(
      products: List<ProductModel>.from(
        (map['products'] as List<int>).map<ProductModel>(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total: map['total'] as int,
      categories: List<c.Category>.from(
        map["categories"].map((x) => categoryValues.map[x]!),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCatalogModel.fromJson(String source) =>
      ProductCatalogModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductCatalogModel(products: $products, total: $total, categories: $categories)';

  @override
  bool operator ==(covariant ProductCatalogModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.products, products) &&
        other.total == total &&
        listEquals(other.categories, categories);
  }

  @override
  int get hashCode => products.hashCode ^ total.hashCode ^ categories.hashCode;
}
