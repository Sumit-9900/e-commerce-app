import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';

class DecrementCartQuantity implements Usecase<void, String> {
  final CartRepository repository;
  DecrementCartQuantity(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.decrementQuantity(id);
  }
}