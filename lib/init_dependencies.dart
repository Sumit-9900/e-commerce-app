import 'package:ecommerce_app/features/cart-checkout/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/cubit/delivery_option_cubit.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/cubit/payment_cubit.dart';
import 'package:ecommerce_app/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_model.dart';
import 'package:ecommerce_app/features/cart/data/repository/cart_repository_impl.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/add_to_cart.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/decrement_cart_quantity.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/delete_all_cart_products.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/get_cart_items.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/increment_cart_quantity.dart';
import 'package:ecommerce_app/features/product-catalog/data/datasources/product_local_datasource.dart';
import 'package:ecommerce_app/features/product-catalog/data/repository/product_repository_impl.dart';
import 'package:ecommerce_app/features/product-catalog/domain/repository/product_repository.dart';
import 'package:ecommerce_app/features/product-catalog/domain/usecases/get_all_products.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/bloc/products_bloc.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/cubit/add_product_to_cart_cubit.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/cubit/filter_cubit.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/cubit/product_details_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(CartModelAdapter());
  }

  final cartBox = await Hive.openBox<CartModel>('cartBox');

  // datasources
  getIt.registerFactory<ProductLocalDatasource>(
    () => ProductLocalDatasourceImpl(),
  );

  getIt.registerFactory<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(cartBox),
  );

  // repository
  getIt.registerFactory<ProductRepository>(
    () => ProductRepositoryImpl(getIt()),
  );

  getIt.registerFactory<CartRepository>(() => CartRepositoryImpl(getIt()));

  // usecase
  getIt.registerFactory(() => GetAllProducts(getIt()));

  getIt.registerFactory(() => AddToCart(getIt()));

  getIt.registerFactory(() => GetCartItems(getIt()));

  getIt.registerFactory(() => DeleteAllCartProducts(getIt()));

  getIt.registerFactory(() => DecrementCartQuantity(getIt()));

  getIt.registerFactory(() => IncrementCartQuantity(getIt()));

  // bloc
  getIt.registerLazySingleton(() => ProductsBloc(getAllProducts: getIt()));

  getIt.registerLazySingleton(
    () => CartBloc(
      getCartItems: getIt(),
      deleteAllCartProducts: getIt(),
      decrementCartQuantity: getIt(),
      incrementCartQuantity: getIt(),
    ),
  );

  // cubit
  getIt.registerFactoryParam<ProductDetailsCubit, String, String>(
    (initialSize, initialColor) => ProductDetailsCubit(
      initialSize: initialSize,
      initialColor: initialColor,
    ),
  );

  getIt.registerLazySingleton(() => FilterCubit());

  getIt.registerLazySingleton(
    () => AddProductToCartCubit(addToCart: getIt(), cartBloc: getIt()),
  );

  getIt.registerLazySingleton(() => DeliveryOptionCubit());

  getIt.registerLazySingleton(() => PaymentCubit());
}
