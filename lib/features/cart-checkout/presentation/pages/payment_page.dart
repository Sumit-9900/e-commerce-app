import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Payment"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Section: Payment Method
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
            _paymentOptionTile(
              context,
              method: 'Credit / Debit Card',
              icon: Icons.credit_card,
              selected: true,
            ),
            _paymentOptionTile(
              context,
              method: 'UPI / Net Banking',
              icon: Icons.account_balance_wallet_outlined,
            ),
            _paymentOptionTile(
              context,
              method: 'Cash on Delivery',
              icon: Icons.payments_outlined,
            ),
            const SizedBox(height: 20),

            // Section: Card Details Form (visible only if card is selected)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter Card Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
            _textField(label: 'Cardholder Name'),
            _textField(label: 'Card Number'),
            Row(
              children: [
                Expanded(child: _textField(label: 'Expiry Date')),
                const SizedBox(width: 12),
                Expanded(child: _textField(label: 'CVV')),
              ],
            ),

            const Spacer(),

            // Pay Now Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(
                    AppRouterConstants.productConfirmationRoute,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Pay Now",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOptionTile(
    BuildContext context, {
    required String method,
    required IconData icon,
    bool selected = false,
  }) {
    return Card(
      elevation: selected ? 2 : 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(
          method,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: Radio<bool>(
          value: true,
          groupValue: selected,
          onChanged: (_) {},
        ),
      ),
    );
  }

  Widget _textField({required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
