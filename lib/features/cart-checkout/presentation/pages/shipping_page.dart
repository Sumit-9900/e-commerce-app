import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:ecommerce_app/core/utils/device_utils.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/cubit/delivery_option_cubit.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/cart_checkout_button.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/delivery_option_tile.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/input_field.dart';
import 'package:ecommerce_app/features/cart-checkout/presentation/widgets/section_title.dart';
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
    final isTablet = DeviceUtils.isTablet(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Shipping Details")),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CartCheckoutButton(
          isTablet: isTablet,
          label: 'Continue',
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.pushNamed(AppRouterConstants.productPaymentRoute);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Shipping Address Form
                SectionTitle(title: 'Shipping Address', isTablet: isTablet),
                const SizedBox(height: 10),
                InputField(
                  label: 'Full Name',
                  controller: nameController,
                  isTablet: isTablet,
                ),
                InputField(
                  label: 'Phone Number',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  isTablet: isTablet,
                ),
                InputField(
                  label: 'Street Address',
                  controller: streetController,
                  keyboardType: TextInputType.streetAddress,
                  isTablet: isTablet,
                ),
                InputField(
                  label: 'City',
                  controller: cityController,
                  isTablet: isTablet,
                ),
                InputField(
                  label: 'Postal Code',
                  controller: postalCodeController,
                  keyboardType: TextInputType.number,
                  isTablet: isTablet,
                ),
                InputField(
                  label: 'Country',
                  controller: countryController,
                  keyboardType: TextInputType.streetAddress,
                  isTablet: isTablet,
                ),

                const SizedBox(height: 20),

                // Delivery Options
                SectionTitle(title: 'Delivery Option', isTablet: isTablet),
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
                          isTablet: isTablet,
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
                          isTablet: isTablet,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
