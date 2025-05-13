import 'package:ecommerce_app/features/cart/data/models/cart_model.dart';
import 'package:hive/hive.dart';

abstract class CartLocalDataSource {
  Future<void> addItem(CartModel model);
  Future<List<CartModel>> getItems();
  Future<void> deleteAllItems();
  Future<void> incrementQuantity(String id);
  Future<void> decrementQuantity(String id);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartModel> box;
  CartLocalDataSourceImpl(this.box);

  @override
  Future<void> addItem(CartModel model) async {
    try {
      await box.put(model.id, model);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<CartModel>> getItems() async {
    return box.values.toList();
  }

  @override
  Future<void> deleteAllItems() async {
    try {
      await box.clear();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> decrementQuantity(String id) async {
    try {
      final item = box.get(id);

      if (item != null && item.quantity > 1) {
        item.quantity -= 1;
        await item.save();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> incrementQuantity(String id) async {
    try {
      final item = box.get(id);

      if (item != null) {
        item.quantity += 1;
        await item.save();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
