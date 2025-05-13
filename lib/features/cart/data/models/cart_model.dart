import 'package:ecommerce_app/features/cart/domain/entities/cart.dart';
import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  int price;
  @HiveField(3)
  int quantity;
  @HiveField(4)
  String color;
  @HiveField(5)
  String size;
  @HiveField(6)
  String image;

  CartModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.color,
    required this.size,
    required this.image,
  });

  factory CartModel.fromEntity(Cart entity) => CartModel(
    id: entity.id,
    title: entity.title,
    price: entity.price,
    quantity: entity.quantity,
    color: entity.color,
    size: entity.size,
    image: entity.image,
  );

  Cart toEntity() => Cart(
    id: id,
    title: title,
    price: price,
    quantity: quantity,
    color: color,
    size: size,
    image: image,
  );
}
