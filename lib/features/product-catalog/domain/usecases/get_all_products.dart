import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/product-catalog/domain/entities/product_catalog.dart';
import 'package:ecommerce_app/features/product-catalog/domain/repository/product_repository.dart';

class GetAllProducts implements Usecase<ProductCatalog, NoParams> {
  final ProductRepository productRepository;
  GetAllProducts(this.productRepository);

  @override
  Future<Either<Failure, ProductCatalog>> call(NoParams params) async {
    return await productRepository.getProducts();
  }
}
