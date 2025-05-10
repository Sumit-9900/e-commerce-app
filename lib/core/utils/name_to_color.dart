import 'package:flutter/material.dart';

import 'package:ecommerce_app/features/product-catalog/domain/enums/color.dart'
    as c;

Color getColorFromName(c.Color color) {
  switch (color) {
    case c.Color.BLACK:
      return Colors.black;
    case c.Color.GREY:
      return Colors.grey;
    case c.Color.MAROON:
      return const Color(0xFF800000);
    case c.Color.NAVY_BLUE:
      return Color(0xFF000080);
    case c.Color.WHITE:
      return Colors.white;
  }
}
