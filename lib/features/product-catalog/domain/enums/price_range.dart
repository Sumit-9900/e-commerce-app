import 'package:ecommerce_app/core/utils/enum_values.dart';

enum PriceRange { under500, from500To1000, from1000To2000, above2000 }

final priceRangeValues = EnumValues({
  "Under ₹500": PriceRange.under500,
  "₹500 - ₹1000": PriceRange.from500To1000,
  "₹1000 - ₹2000": PriceRange.from1000To2000,
  "Above ₹2000": PriceRange.above2000,
});
