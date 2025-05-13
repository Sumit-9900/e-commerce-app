import 'package:ecommerce_app/core/constants/const.dart';
import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/core/utils/order_utils.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/checkout_item_tile.dart';
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
    final theme = Theme.of(context);
    final subTotal = OrderUtils.getSubtotal(widget.cartProducts);
    final tax = OrderUtils.getTax(subTotal);
    final shipping = OrderUtils.getShipping(subTotal);
    final totalPrice = OrderUtils.getTotal(subTotal);

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Delivery Address Section
            _sectionTitle("Products"),
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
                  );
                },
              ),
            ),

            // const SizedBox(height: 20),

            // _sectionTitle("Promo Code"),
            // const SizedBox(height: 6),
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextField(
            //         controller: _promoController,
            //         decoration: InputDecoration(
            //           hintText: "Enter code",
            //           errorText: '',
            //           contentPadding: const EdgeInsets.symmetric(
            //             horizontal: 12,
            //             vertical: 10,
            //           ),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(8),
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     ElevatedButton(
            //       onPressed: () {},
            //       style: ElevatedButton.styleFrom(
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 16,
            //           vertical: 14,
            //         ),
            //       ),
            //       child: const Text("Apply"),
            //     ),
            //   ],
            // ),
            // if (_appliedCode != null)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 4),
            //     child: Align(
            //       alignment: Alignment.centerLeft,
            //       child: Text(
            //         "Code '$_appliedCode' applied (${(_discountPercent * 100).toInt()}% off)",
            //         style: const TextStyle(color: Colors.green, fontSize: 12),
            //       ),
            //     ),
            //   ),
            const SizedBox(height: 20),

            // Order Summary
            _sectionTitle("Order Summary"),
            _infoCard(
              context,
              child: Column(
                children: [
                  _SummaryRow(
                    "Subtotal",
                    "${Const.indianRuppee}${subTotal.toStringAsFixed(1)}",
                  ),
                  _SummaryRow(
                    "Shipping",
                    "${Const.indianRuppee}${shipping.toStringAsFixed(1)}",
                  ),
                  _SummaryRow(
                    "Tax",
                    "${Const.indianRuppee}${tax.toStringAsFixed(1)}",
                  ),
                  Divider(),
                  _SummaryRow(
                    "Total",
                    "${Const.indianRuppee}${totalPrice.toStringAsFixed(1)}",
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Checkout Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(AppRouterConstants.productShippingRoute);
                  // Proceed to place order
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Place Order",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

class _SummaryRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isTotal;

  const _SummaryRow(this.label, this.amount, {this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: isTotal ? 16 : 14,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle),
          Text(amount, style: textStyle),
        ],
      ),
    );
  }
}

// import 'package:ecommerce_app/core/router/app_router_constants.dart';
// import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/checkout_item_tile.dart';
// import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class CheckoutPage extends StatefulWidget {
//   final List<Cart> cartProducts;
//   const CheckoutPage({super.key, required this.cartProducts});

//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   final TextEditingController _promoController = TextEditingController();
//   // final Map<String, double> promoCodes = {'SAVE10': 0.10, 'DISCOUNT20': 0.20};

//   // String? _appliedCode;
//   // String? _errorText;
//   // double _discountPercent = 0.0;

//   // double get subtotal => widget.cartProducts.fold(
//   //   0.0,
//   //   (sum, item) => sum + (item.price * item.quantity),
//   // );

//   // double get shipping => 8.0;

//   // double get total => (subtotal - subtotal * _discountPercent) + shipping;

//   // void applyPromoCode() {
//   //   final code = _promoController.text.trim().toUpperCase();

//   //   if (promoCodes.containsKey(code)) {
//   //     setState(() {
//   //       _appliedCode = code;
//   //       _discountPercent = promoCodes[code]!;
//   //       _errorText = null;
//   //     });
//   //   } else {
//   //     setState(() {
//   //       _appliedCode = null;
//   //       _discountPercent = 0.0;
//   //       _errorText = 'Invalid promo code';
//   //     });
//   //   }
//   // }

//   @override
//   void dispose() {
//     _promoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(title: const Text("Checkout"), centerTitle: true),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Section Title
//             _sectionTitle("Products"),
//             const SizedBox(height: 2),

//             // Product List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: widget.cartProducts.length,
//                 itemBuilder: (context, index) {
//                   final cartProduct = widget.cartProducts[index];
//                   return CheckoutItemTile(
//                     imageUrl: cartProduct.image,
//                     title: cartProduct.title,
//                     price: cartProduct.price.toDouble(),
//                     size: cartProduct.size,
//                     color: cartProduct.color,
//                     quantity: cartProduct.quantity.toString(),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Promo Code Section
//             _sectionTitle("Promo Code"),
//             const SizedBox(height: 6),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _promoController,
//                     decoration: InputDecoration(
//                       hintText: "Enter code",
//                       errorText: _errorText,
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 10,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: applyPromoCode,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 14,
//                     ),
//                   ),
//                   child: const Text("Apply"),
//                 ),
//               ],
//             ),
//             if (_appliedCode != null)
//               Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Code '$_appliedCode' applied (${(_discountPercent * 100).toInt()}% off)",
//                     style: const TextStyle(color: Colors.green, fontSize: 12),
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 20),

//             // Order Summary
//             _sectionTitle("Order Summary"),
//             _infoCard(
//               context,
//               child: Column(
//                 children: [
//                   _SummaryRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
//                   _SummaryRow("Shipping", "\$${shipping.toStringAsFixed(2)}"),
//                   if (_discountPercent > 0)
//                     _SummaryRow(
//                       "Discount",
//                       "-\$${(subtotal * _discountPercent).toStringAsFixed(2)}",
//                     ),
//                   const Divider(),
//                   _SummaryRow(
//                     "Total",
//                     "\$${total.toStringAsFixed(2)}",
//                     isTotal: true,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Checkout Button
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   context.pushNamed(AppRouterConstants.productShippingRoute);
//                   // Proceed to place order
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: theme.colorScheme.primary,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   "Place Order",
//                   style: TextStyle(fontSize: 18, color: Colors.black),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//       ),
//     );
//   }

//   Widget _infoCard(BuildContext context, {required Widget child}) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 1,
//       color: Colors.white,
//       child: Padding(padding: const EdgeInsets.all(12.0), child: child),
//     );
//   }
// }

// class _SummaryRow extends StatelessWidget {
//   final String label;
//   final String amount;
//   final bool isTotal;

//   const _SummaryRow(this.label, this.amount, {this.isTotal = false});

//   @override
//   Widget build(BuildContext context) {
//     final textStyle = TextStyle(
//       fontSize: isTotal ? 16 : 14,
//       fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//     );

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: textStyle),
//           Text(amount, style: textStyle),
//         ],
//       ),
//     );
//   }
// }
