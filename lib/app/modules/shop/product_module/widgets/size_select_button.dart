import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/mixins/select_product_option_mixin.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/text.dart';

class SizeSelectButton extends StatelessWidget {
  const SizeSelectButton({
    Key? key,
    required this.product,
    required this.controller,
  }) : super(key: key);

  final Map<String, dynamic> product;
  final SelectProductOptionMixin controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonFormField2(
        isDense: false,
        buttonPadding: const EdgeInsets.only(right: 16),
        disabledHint: DefaultText(
          '색상을 먼저 지정해주세요',
          style: TextStyle(fontSize: 16, color: Colors.grey[500]),
        ),
        itemPadding: const EdgeInsets.symmetric(horizontal: 16),
        buttonElevation: 0,
        dropdownDecoration: BoxDecoration(
            boxShadow: const [],
            border: Border.all(width: 1, color: Colors.grey[600]!),
            borderRadius: BorderRadius.circular(8)),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        hint: DefaultText(
          '사이즈를 선택하세요',
          style: Get.textTheme.labelLarge,
        ),
        value: controller.productDetailsOfSelectedColor
                .contains(controller.selectedProductDetail)
            ? controller.selectedProductDetail
            : null,
        items: controller.productDetailsOfSelectedColor
            .map(
              (option) => DropdownMenuItem<Map<String, dynamic>>(
                value: option,
                child: Text(
                  "${option['size']} ${option['priceAdditional'] > 0 ? ' + ${formatMoney(option['priceAdditional'])}' : ''}",
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
            .toList(),
        onChanged: controller.selectedColor != null
            ? (value) {
                controller.selectedProductDetail = value;
              }
            : null,
      ),
    );
  }
}
