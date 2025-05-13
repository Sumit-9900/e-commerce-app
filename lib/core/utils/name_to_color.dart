import 'package:flutter/material.dart';

import 'package:ecommerce_app/features/product-catalog/domain/enums/color.dart'
    as c;

Color getColorFromName(c.Color color) {
  switch (color) {
    case c.Color.black:
      return Colors.black;
    case c.Color.grey:
      return Colors.grey;
    case c.Color.maroon:
      return const Color(0xFF800000);
    case c.Color.navyBlue:
      return Color(0xFF000080);
    case c.Color.white:
      return Colors.white;
  }
}
