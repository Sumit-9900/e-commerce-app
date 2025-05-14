import 'package:ecommerce_app/core/router/app_router_config.dart';
import 'package:ecommerce_app/core/theme/app_theme.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/cubit/delivery_option_cubit.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/cubit/payment_cubit.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/sort_options.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/bloc/products_bloc.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/cubit/add_product_to_cart_cubit.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/cubit/filter_cubit.dart';
import 'package:ecommerce_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  getIt<ProductsBloc>()
                    ..add(ProductsFetched(sortOptions: SortOptions.newest)),
        ),
        BlocProvider(create: (_) => getIt<FilterCubit>()),
        BlocProvider(create: (_) => getIt<AddProductToCartCubit>()),
        BlocProvider(
          create: (_) => getIt<CartBloc>()..add(CartProductsFetched()),
        ),
        BlocProvider(create: (_) => getIt<PaymentCubit>()),
        BlocProvider(create: (_) => getIt<DeliveryOptionCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ecommerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.light,
      routerConfig: AppRouterConfig.router,
    );
  }
}
