import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/cubit/delivery_option_cubit.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/delivery_option_tile.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DeliveryOptionCubit>().resetDeliveryOption();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Shipping Details"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                InputField(label: 'Full Name', controller: nameController),
                InputField(
                  label: 'Phone Number',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),
                InputField(
                  label: 'Street Address',
                  controller: streetController,
                  keyboardType: TextInputType.streetAddress,
                ),
                InputField(label: 'City', controller: cityController),
                InputField(
                  label: 'Postal Code',
                  controller: postalCodeController,
                  keyboardType: TextInputType.number,
                ),
                InputField(
                  label: 'Country',
                  controller: countryController,
                  keyboardType: TextInputType.streetAddress,
                ),

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

                BlocBuilder<DeliveryOptionCubit, DeliveryOptionState>(
                  builder: (context, state) {
                    final selected =
                        state is DeliveryOptionSuccess
                            ? state.option
                            : DeliveryOption.standard;

                    return Column(
                      children: [
                        DeliveryOptionTile(
                          title: "Standard Delivery",
                          subtitle: "3 - 5 business days",
                          price: "Free",
                          selected: selected == DeliveryOption.standard,
                          onTap:
                              () => context
                                  .read<DeliveryOptionCubit>()
                                  .toggleDeliveryOption(
                                    DeliveryOption.standard,
                                  ),
                        ),
                        DeliveryOptionTile(
                          title: "Express Delivery",
                          subtitle: "1 - 2 business days",
                          price: "Free",
                          selected: selected == DeliveryOption.express,
                          onTap:
                              () => context
                                  .read<DeliveryOptionCubit>()
                                  .toggleDeliveryOption(DeliveryOption.express),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 10),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Navigate to payment or next step
                        context.pushNamed(
                          AppRouterConstants.productPaymentRoute,
                        );
                      }
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
      ),
    );
  }
}
