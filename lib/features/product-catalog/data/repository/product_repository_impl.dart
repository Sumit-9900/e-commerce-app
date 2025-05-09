import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product-catalog/data/datasources/product_local_datasource.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/product_catalog.dart';
import 'package:ecommerce_app/features/product-catalog/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDatasource productLocalDatasource;
  ProductRepositoryImpl(this.productLocalDatasource);

  @override
  Future<Either<Failure, ProductCatalog>> getProducts() async {
    try {
      final products = await productLocalDatasource.getProducts();
      return right(products.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
