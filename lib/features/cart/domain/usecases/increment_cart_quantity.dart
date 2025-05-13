import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';

class IncrementCartQuantity implements Usecase<void, String> {
  final CartRepository repository;
  IncrementCartQuantity(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.incrementQuantity(id);
  }
}
