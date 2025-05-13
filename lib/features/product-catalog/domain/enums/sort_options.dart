import 'package:ecommerce_app/core/utils/enum_values.dart';

enum SortOptions { newest, popularity, priceLowToHigh, priceHighToLow }

final sortOptionsValues = EnumValues({
  "Newest": SortOptions.newest,
  "Popularity": SortOptions.popularity,
  "Price: Low to High": SortOptions.priceLowToHigh,
  "Price: High to Low": SortOptions.priceHighToLow,
});
