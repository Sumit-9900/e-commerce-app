import 'package:ecommerce_app/core/utils/name_to_color.dart';
import 'package:ecommerce_app/core/widgets/size_color_quantity_tile.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/size.dart'
    as s;
import 'package:ecommerce_app/features/product-catalog/domain/enums/color.dart'
    as c;

void bottomDraggableSheet(
  BuildContext context, {
  required String headingText,
  required List<dynamic> variants,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.4 + (variants.length * 0.1),
        minChildSize: 0.1,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        headingText,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 15),
                      itemCount: variants.length,
                      itemBuilder: (context, index) {
                        final variant = variants[index];

                        String displayText = '';
                        Widget trailingWidget = Container();
                        if (variant is s.Size) {
                          displayText =
                              s.sizeValues.reverse[variant] ?? 'Unknown Size';
                        } else if (variant is c.Color) {
                          displayText =
                              c.colorValues.reverse[variant] ?? 'Unknown Color';
                          trailingWidget = CircleAvatar(
                            radius: 15,
                            backgroundColor: getColorFromName(variant),
                          );
                        }
                        return SizeColorQuantityTile(
                          text: displayText,
                          widget: trailingWidget,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
