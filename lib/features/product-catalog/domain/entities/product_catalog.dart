import 'package:ecommerce_app/features/product-catalog/domain/entities/product.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/category.dart';

class ProductCatalog {
  List<Product> products;
  int total;
  List<Category> categories;

  ProductCatalog({
    required this.products,
    required this.total,
    required this.categories,
  });
}
