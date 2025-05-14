import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/product_catalog.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, ProductCatalog>> getProducts();
}
