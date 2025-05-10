import 'package:ecommerce_app/features/product-catalog/data/datasources/product_local_datasource.dart';
import 'package:ecommerce_app/features/product-catalog/data/repository/product_repository_impl.dart';
import 'package:ecommerce_app/features/product-catalog/domain/repository/product_repository.dart';
import 'package:ecommerce_app/features/product-catalog/domain/usecases/get_all_products.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/bloc/products_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initDependencies() {
  // datasources
  getIt.registerFactory<ProductLocalDatasource>(
    () => ProductLocalDatasourceImpl(),
  );

  // repository
  getIt.registerFactory<ProductRepository>(
    () => ProductRepositoryImpl(getIt()),
  );

  // usecase
  getIt.registerFactory(() => GetAllProducts(getIt()));

  // bloc
  getIt.registerLazySingleton(() => ProductsBloc(getAllProducts: getIt()));
}
