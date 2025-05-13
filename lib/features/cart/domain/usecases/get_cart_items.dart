import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';

class GetCartItems implements Usecase<List<Cart>, NoParams> {
  final CartRepository repository;
  GetCartItems(this.repository);

  @override
  Future<Either<Failure, List<Cart>>> call(NoParams params) async {
    return await repository.getCartItems();
  }
}
