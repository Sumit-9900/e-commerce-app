import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

final class NoParams {}
