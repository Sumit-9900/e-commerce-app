import 'package:ecommerce_app/core/utils/enum_values.dart';

enum Rating { above4Star, above3Star, above2Star }

final ratingValues = EnumValues({
  "4★ & above": Rating.above4Star,
  "3★ & above": Rating.above3Star,
  "2★ & above": Rating.above2Star,
});
