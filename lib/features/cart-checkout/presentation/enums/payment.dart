import 'package:ecommerce_app/core/utils/enum_values.dart';

enum PaymentMethod { card, upi, cod }

final paymentMethodValues = EnumValues({
  "Credit/Debit Card": PaymentMethod.card,
  "UPI/Net Banking": PaymentMethod.upi,
  "Cash on Delivery": PaymentMethod.cod,
});
