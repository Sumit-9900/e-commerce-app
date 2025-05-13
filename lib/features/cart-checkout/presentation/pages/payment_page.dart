import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final formKey = GlobalKey<FormState>();
  final cardHolderController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  void dispose() {
    cardHolderController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Payment"), centerTitle: true),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.pushNamed(AppRouterConstants.productConfirmationRoute);
              }
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                InputField(
                  label: 'Cardholder Name',
                  controller: cardHolderController,
                ),
                InputField(
                  label: 'Card Number',
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        label: 'Expiry Date',
                        controller: expiryDateController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InputField(
                        label: 'CVV',
                        controller: cvvController,
                        keyboardType: TextInputType.number,
                        isObscured: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
}
