import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/cubit/payment_cubit.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/enums/payment.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/input_field.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/payment_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final upiIdController = TextEditingController();
  final bankNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().resetPaymentMethod();
  }

  @override
  void dispose() {
    cardHolderController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    upiIdController.dispose();
    bankNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
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
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          final selected =
              state is PaymentSuccess ? state.method : PaymentMethod.card;

          return Padding(
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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    PaymentOptionTile(
                      title: 'Credit / Debit Card',
                      icon: Icons.credit_card,
                      selected: selected == PaymentMethod.card,
                      onTap:
                          () => context.read<PaymentCubit>().changePaymentTile(
                            PaymentMethod.card,
                          ),
                    ),
                    PaymentOptionTile(
                      title: 'UPI / Net Banking',
                      icon: Icons.account_balance_wallet_outlined,
                      selected: selected == PaymentMethod.upi,
                      onTap:
                          () => context.read<PaymentCubit>().changePaymentTile(
                            PaymentMethod.upi,
                          ),
                    ),
                    PaymentOptionTile(
                      title: 'Cash on Delivery',
                      icon: Icons.payments_outlined,
                      selected: selected == PaymentMethod.cod,
                      onTap:
                          () => context.read<PaymentCubit>().changePaymentTile(
                            PaymentMethod.cod,
                          ),
                    ),
                    const SizedBox(height: 20),

                    // Dynamic Form Section
                    if (selected == PaymentMethod.card) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Enter Card Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
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
                              keyboardType: TextInputType.datetime,
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
                    ] else if (selected == PaymentMethod.upi) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Enter UPI / Net Banking Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InputField(label: 'UPI ID', controller: upiIdController),
                      InputField(
                        label: 'Bank Name',
                        controller: bankNameController,
                      ),
                    ] else if (selected == PaymentMethod.cod) ...[
                      const Text(
                        'No additional details required for Cash on Delivery.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
