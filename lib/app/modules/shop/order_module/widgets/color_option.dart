import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_controller.dart';

class ColorOption extends StatelessWidget {
  const ColorOption({
    super.key,
    required this.controller,
    required this.color,
  });

  final SpeedOrderItemController controller;
  final String color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
              value: controller.productListOfEachColor
                  .where((p) => p['color'] == color)
                  .isNotEmpty,
              onChanged: (value) {
                //   if (value!) {
                //     controller.productListOfEachColor.add({
                //       'color': color,
                //       'productList': controller.selectedProductMaster['products']
                //           .where((p) => p['color'] == color)
                //           .toList()
                //     });
                //   } else {
                //     controller.productListOfEachColor
                //         .removeWhere((element) => element['color'] == color);
                //   }
                //   controller.productListOfEachColor.refresh();
              }),
        ),
        Text(
          color,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
