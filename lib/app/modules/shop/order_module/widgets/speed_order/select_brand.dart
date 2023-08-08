import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_controller.dart';

class SelectBrand extends StatelessWidget {
  const SelectBrand({Key? key, required this.controller}) : super(key: key);

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
          () => DropdownButton2<String?>(
            dropdownMaxHeight: 400,
            isExpanded: true,
            hint: const Text(
              '브랜드 선택',
              style: TextStyle(fontSize: 16),
            ),
            value: controller.selectedBrand,
            items: controller.brandList
                .map(
                  (brand) => DropdownMenuItem<String>(
                    value: brand,
                    child: DefaultText(
                      brand,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                )
                .toList(),
            onChanged: (String? value) async {
              controller.selectedBrand = value;
            },
          ),
        ),
      ),
    );
  }
}
