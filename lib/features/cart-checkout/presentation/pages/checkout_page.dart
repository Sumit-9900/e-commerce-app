import 'package:ecommerce_app/core/constants/const.dart';
import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/core/utils/device_utils.dart';
import 'package:ecommerce_app/core/utils/order_utils.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/cart_checkout_button.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/checkout_item_tile.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/section_title.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/summary_tile.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutPage extends StatefulWidget {
  final List<Cart> cartProducts;
  const CheckoutPage({super.key, required this.cartProducts});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subTotal = OrderUtils.getSubtotal(widget.cartProducts);
    final tax = OrderUtils.getTax(subTotal);
    final shipping = OrderUtils.getShipping(subTotal);
    final totalPrice = OrderUtils.getTotal(subTotal);
    final isTablet = DeviceUtils.isTablet(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Delivery Address Section
            SectionTitle(title: "Products", isTablet: isTablet),
            const SizedBox(height: 2),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartProducts.length,
                itemBuilder: (context, index) {
                  final cartProduct = widget.cartProducts[index];
                  return CheckoutItemTile(
                    imageUrl: cartProduct.image,
                    title: cartProduct.title,
                    price: cartProduct.price.toDouble(),
                    size: cartProduct.size,
                    color: cartProduct.color,
                    quantity: cartProduct.quantity.toString(),
                    isTablet: isTablet,
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Order Summary
            SectionTitle(title: "Order Summary", isTablet: isTablet),
            _infoCard(
              context,
              child: Column(
                children: [
                  SummaryTile(
                    title: "Subtotal",
                    value:
                        "${Const.indianRuppee}${subTotal.toStringAsFixed(1)}",
                    isTablet: isTablet,
                  ),
                  SummaryTile(
                    title: "Shipping",
                    value:
                        "${Const.indianRuppee}${shipping.toStringAsFixed(1)}",
                    isTablet: isTablet,
                  ),
                  SummaryTile(
                    title: "Tax",
                    value: "${Const.indianRuppee}${tax.toStringAsFixed(1)}",
                    isTablet: isTablet,
                  ),
                  Divider(),
                  SummaryTile(
                    title: "Total",
                    value:
                        "${Const.indianRuppee}${totalPrice.toStringAsFixed(1)}",
                    isTablet: isTablet,
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CartCheckoutButton(
              isTablet: isTablet,
              label: 'Place Order',
              onPressed: () {
                context.pushNamed(AppRouterConstants.productShippingRoute);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(BuildContext context, {required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      color: Colors.white,
      child: Padding(padding: const EdgeInsets.all(12.0), child: child),
    );
  }
}
