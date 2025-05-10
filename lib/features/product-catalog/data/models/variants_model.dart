import 'package:ecommerce_app/features/product-catalog/domain/entities/variants.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/color.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/size.dart';

class VariantsModel {
  final List<Size> sizes;
  final List<Color> colors;

  VariantsModel({required this.sizes, required this.colors});

  // Convert to domain entity
  Variants toEntity() => Variants(sizes: sizes, colors: colors);

  // Convert from domain entity
  factory VariantsModel.fromEntity(Variants variants) =>
      VariantsModel(sizes: variants.sizes, colors: variants.colors);

  // Serialization
  Map<String, dynamic> toMap() => {
    'sizes': sizes.map((e) => e.name).toList(),
    'colors': colors.map((e) => e.name).toList(),
  };

  factory VariantsModel.fromMap(Map<String, dynamic> map) => VariantsModel(
    sizes: List<Size>.from(map['sizes'].map((x) => sizeValues.map[x]!)),
    colors: List<Color>.from(map['colors'].map((x) => colorValues.map[x]!)),
  );

  @override
  String toString() => 'VariantsModel(sizes: $sizes, colors: $colors)';
}
