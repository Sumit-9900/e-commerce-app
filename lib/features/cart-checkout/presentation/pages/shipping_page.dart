import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShippingPage extends StatelessWidget {
  const ShippingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Shipping Details"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Shipping Address Form
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Shipping Address',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              _textField(label: 'Full Name'),
              _textField(label: 'Phone Number'),
              _textField(label: 'Street Address'),
              _textField(label: 'City'),
              _textField(label: 'Postal Code'),
              _textField(label: 'Country'),

              const SizedBox(height: 20),

              // Delivery Options
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Delivery Option',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              _deliveryOptionTile(
                title: "Standard Delivery",
                subtitle: "3 - 5 business days",
                price: "Free",
                selected: true,
              ),
              _deliveryOptionTile(
                title: "Express Delivery",
                subtitle: "1 - 2 business days",
                price: "\$8.00",
              ),

              const SizedBox(height: 10),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to payment or next step
                    context.pushNamed(AppRouterConstants.productPaymentRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
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

  Widget _deliveryOptionTile({
    required String title,
    required String subtitle,
    required String price,
    bool selected = false,
  }) {
    return Card(
      elevation: selected ? 2 : 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Radio<bool>(
          value: true,
          groupValue: selected,
          onChanged: (_) {},
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: Text(
          price,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
