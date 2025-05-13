import 'package:ecommerce_app/features/cart/data/models/cart_model.dart';
import 'package:hive/hive.dart';

abstract class CartLocalDataSource {
  Future<void> addItem(CartModel model);
  Future<List<CartModel>> getItems();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartModel> box;
  CartLocalDataSourceImpl(this.box);

  @override
  Future<void> addItem(CartModel model) async {
    await box.put(model.id, model);
  }

  @override
  Future<List<CartModel>> getItems() async {
    return box.values.toList();
  }
}
