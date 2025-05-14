import 'package:ecommerce_app/features/product-catalog/domain/enums/color.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/size.dart';

class Variants {
  List<Size> sizes;
  List<Color> colors;

  Variants({required this.sizes, required this.colors});
}
