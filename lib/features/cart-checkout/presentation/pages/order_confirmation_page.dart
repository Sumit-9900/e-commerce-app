import 'package:ecommerce_app/core/constants/const.dart';
import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/core/utils/device_utils.dart';
import 'package:ecommerce_app/core/utils/order_utils.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/cubit/payment_cubit.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/enums/payment.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/cart_checkout_button.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/summary_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final estimatedDelivery =
        DateTime.now().add(Duration(days: 3)).toString().split(' ').first;
    final paymentMethod =
        (context.read<PaymentCubit>().state as PaymentSuccess).method;
    final paymentInString = paymentMethodValues.reverse[paymentMethod] ?? '';
    final cartProducts =
        (context.read<CartBloc>().state as CartSuccess).cartProducts;
    final totalProductPrice = OrderUtils.getSubtotal(cartProducts);
    final totalAmount = OrderUtils.getTotal(totalProductPrice);
    final uniqueId = '#ORD${Uuid().v4().split('-').first.toUpperCase()}';
    final isTablet = DeviceUtils.isTablet(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Order Confirmation")),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: CartCheckoutButton(
          isTablet: isTablet,
          label: 'Continue Shopping',
          onPressed: () {
            context.goNamed(AppRouterConstants.productCatalogRoute);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // ✅ Success Icon
            Icon(
              Icons.check_circle_outline_rounded,
              size: isTablet ? 120 : 90,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 20),

            // ✅ Thank You Message
            Text(
              "Thank You!",
              style: TextStyle(
                fontSize: isTablet ? 34 : 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Your order has been placed successfully.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet ? 24 : 16,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),

            // ✅ Order Summary
            SummaryTile(title: 'Order ID', value: uniqueId, isTablet: isTablet),
            SummaryTile(
              title: 'Estimated Delivery',
              value: estimatedDelivery,
              isTablet: isTablet,
            ),
            SummaryTile(
              title: 'Payment Method',
              value: paymentInString,
              isTablet: isTablet,
            ),
            SummaryTile(
              title: 'Total Amount',
              value: '${Const.indianRuppee}${totalAmount.toStringAsFixed(1)}',
              isTablet: isTablet,
            ),
          ],
        ),
      ),
    );
  }
}
