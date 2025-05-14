import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';

class DeleteAllCartProducts implements Usecase<void, NoParams> {
  final CartRepository repository;
  DeleteAllCartProducts(this.repository);
  
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.deleteCartItems();
  }
}