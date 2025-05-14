import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_model.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;
  CartRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> addToCart(Cart entity) async {
    try {
      final model = CartModel.fromEntity(entity);
      await localDataSource.addItem(model);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Cart>>> getCartItems() async {
    try {
      final models = await localDataSource.getItems();
      final carts = models.map((e) => e.toEntity()).toList();
      return right(carts);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCartItems() async {
    try {
      await localDataSource.deleteAllItems();
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> decrementQuantity(String id) async {
    try {
      await localDataSource.decrementQuantity(id);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> incrementQuantity(String id) async {
    try {
      await localDataSource.incrementQuantity(id);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
