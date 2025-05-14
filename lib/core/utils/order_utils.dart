import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';

class OrderUtils {
  static const double flatShippingRate = 60.0;
  static const double taxRate = 0.18;

  static double getSubtotal(List<Cart> items) {
    return items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  static double getTax(double subtotal) {
    return subtotal * taxRate;
  }

  static double getShipping(double subtotal) {
    return subtotal > 1000 ? 0 : flatShippingRate;
  }

  static double getTotal(double subtotal) {
    return subtotal + getTax(subtotal) + getShipping(subtotal);
  }
}
