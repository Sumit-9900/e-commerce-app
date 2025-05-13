import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addToCart(Cart entity);
  Future<Either<Failure, List<Cart>>> getCartItems();
}
