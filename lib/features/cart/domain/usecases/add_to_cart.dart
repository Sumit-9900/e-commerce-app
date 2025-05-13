import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';

class AddToCart implements Usecase<void, Cart> {
  final CartRepository repository;
  AddToCart(this.repository);

  @override
  Future<Either<Failure, void>> call(Cart cart) async {
    return await repository.addToCart(cart);
  }
}
