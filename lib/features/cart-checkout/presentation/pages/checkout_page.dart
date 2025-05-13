import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Delivery Address Section
            _sectionTitle("Delivery Address"),
            _infoCard(
              context,
              child: ListTile(
                title: const Text("John Doe"),
                subtitle: const Text("1234 Flutter St, Code City, 56789"),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text("Change"),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Payment Method Section
            _sectionTitle("Payment Method"),
            _infoCard(
              context,
              child: ListTile(
                title: const Text("Visa"),
                subtitle: const Text("**** **** **** 1234"),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text("Change"),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Order Summary
            _sectionTitle("Order Summary"),
            _infoCard(
              context,
              child: Column(
                children: const [
                  _summaryRow("Subtotal", "\$200"),
                  _summaryRow("Shipping", "\$8.00"),
                  _summaryRow("Tax", "\$0.00"),
                  Divider(),
                  _summaryRow("Total", "\$208", isTotal: true),
                ],
              ),
            ),
            const Spacer(),

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

class _summaryRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isTotal;

  const _summaryRow(this.label, this.amount, {this.isTotal = false});

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
