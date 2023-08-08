import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_controller.dart';

class SelectProductMaster extends StatelessWidget {
  const SelectProductMaster({Key? key, required this.controller})
      : super(key: key);

  final SpeedOrderItemController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(
          () => DropdownButton2(
            isExpanded: true,
            dropdownMaxHeight: 400,
            hint: const DefaultText(
              '상품선택',
              style: TextStyle(fontSize: 16),
            ),
            value: controller.selectedProductMasterName,
            items: controller.productMasterNameList
                .map(
                  (productMasterName) => DropdownMenuItem(
                    value: productMasterName,
                    child: DefaultText(productMasterName,
                        maxLines: 3, style: const TextStyle(fontSize: 16)),
                  ),
                )
                .toList(),
            onChanged: (value) async {
              controller.selectedProductMasterName = value;
              if (controller.useName) {
                controller.addNameOption();
              }
            },
          ),
        ),
      ),
    );
  }
}
