import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/utils/device_utils.dart';
import 'package:ecommerce_app/core/utils/name_to_color.dart';
import 'package:ecommerce_app/core/widgets/common_tile.dart';
import 'package:ecommerce_app/features/product-catalog/presentation/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/features/product-catalog/domain/enums/size.dart'
    as s;
import 'package:ecommerce_app/features/product-catalog/domain/enums/color.dart'
    as c;
import 'package:flutter_bloc/flutter_bloc.dart';

void bottomDraggableSheet(
  BuildContext context, {
  required String headingText,
  required List<dynamic> variants,
}) {
  final detailsCubit = context.read<ProductDetailsCubit>();
  showModalBottomSheet(
    context: context,
    builder: (sheetContext) {
      return DraggableScrollableSheet(
        initialChildSize:
            DeviceUtils.isTablet(context)
                ? 0.1 + (variants.length * 0.1)
                : 0.4 + (variants.length * 0.1),
        minChildSize: 0.1,
        maxChildSize: 0.9,
        expand: false,
        builder: (ctx, scrollController) {
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
                  BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                    bloc: detailsCubit,
                    builder: (_, state) {
                      return Expanded(
                        child: ListView.separated(
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 15),
                          itemCount: variants.length,
                          itemBuilder: (context, index) {
                            final variant = variants[index];

                            String displayText = '';
                            Widget trailingWidget = Container();
                            if (variant is s.Size) {
                              displayText = s.sizeValues.reverse[variant] ?? '';
                              trailingWidget =
                                  (state is ProductDetailsSuccess &&
                                          state.size == displayText)
                                      ? Icon(Icons.done, color: Colors.black)
                                      : Container();
                            } else if (variant is c.Color) {
                              displayText =
                                  c.colorValues.reverse[variant] ?? '';
                              trailingWidget = Row(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: getColorFromName(variant),
                                  ),
                                  const SizedBox(width: 20),
                                  (state is ProductDetailsSuccess &&
                                          state.color == displayText)
                                      ? Icon(Icons.done, color: Colors.black)
                                      : Container(),
                                ],
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                if (variant is s.Size) {
                                  final sizeName =
                                      s.sizeValues.reverse[variant] ?? '';

                                  detailsCubit.changeSize(sizeName);
                                } else if (variant is c.Color) {
                                  final newColor =
                                      c.colorValues.reverse[variant]!;
                                  detailsCubit.changeColor(newColor);
                                }
                                Navigator.of(context).pop();
                              },
                              child: CommonTile(
                                text: displayText,
                                widget: trailingWidget,
                                color:
                                    (state is ProductDetailsSuccess &&
                                            ((state.size == displayText) ||
                                                (state.color == displayText)))
                                        ? AppColors.purpleColor
                                        : AppColors.tileColor,
                              ),
                            );
                          },
                        ),
                      );
                    },
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
