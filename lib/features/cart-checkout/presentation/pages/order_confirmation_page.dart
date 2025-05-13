import 'package:ecommerce_app/core/constants/const.dart';
import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/core/utils/order_utils.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/cubit/payment_cubit.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/enums/payment.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Confirmation"),
        centerTitle: true,
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
              size: 90,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 20),

            // ✅ Thank You Message
            const Text(
              "Thank You!",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Your order has been placed successfully.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),

            // ✅ Order Summary
            _orderSummaryTile('Order ID', uniqueId),
            _orderSummaryTile('Estimated Delivery', estimatedDelivery),
            _orderSummaryTile('Payment Method', paymentInString),
            _orderSummaryTile(
              'Total Amount',
              '${Const.indianRuppee}${totalAmount.toStringAsFixed(1)}',
            ),

            const Spacer(),

            // ✅ Continue Shopping Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.goNamed(AppRouterConstants.productCatalogRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Continue Shopping",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // 🔹 Reusable Order Summary Tile
  Widget _orderSummaryTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
