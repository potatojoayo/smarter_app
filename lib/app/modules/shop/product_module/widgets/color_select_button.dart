import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/mixins/select_product_option_mixin.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';

class ColorSelectButton extends StatelessWidget {
  const ColorSelectButton({
    Key? key,
    required this.product,
    required this.controller,
  }) : super(key: key);

  final Map<String, dynamic> product;
  final SelectProductOptionMixin controller;

  @override
  Widget build(BuildContext context) {
    final items = RxList<Widget>.from(
      product['colors'].map(
        (color) {
          return InkWell(
            onTap: () {
              controller.selectedColor = color;
              // controller.selectedProductDetail = null;
              controller.productDetailsOfSelectedColor.assignAll(
                List<Map<String, dynamic>>.from(
                  product['products'].where((p) => p['color'] == color),
                ),
              );
            },
            child: Obx(
              () => FittedBox(
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: color == controller.selectedColor ? textColor : null,
                    border: Border.all(
                      color: textColor,
                    ),
                  ),
                  child: Center(
                    child: DefaultTextStyle(
                        style: TextStyle(
                          color: color == controller.selectedColor
                              ? backgroundColor
                              : textColor,
                          fontSize: 15,
                        ),
                        child: DefaultText(color)),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: items,
      ),
    );
  }
}
