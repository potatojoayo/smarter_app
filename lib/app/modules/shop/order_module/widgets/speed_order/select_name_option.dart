import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_controller.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_option_controller.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/speed_order/speed_order_select_name_and_quantity.dart';

class SelectNameOption extends StatefulWidget {
  const SelectNameOption(
      {Key? key, required this.controller, required this.optionController})
      : super(key: key);

  final SpeedOrderItemController controller;
  final SpeedOrderItemOptionController optionController;

  @override
  State<SelectNameOption> createState() => _SelectNameOptionState();
}

class _SelectNameOptionState extends State<SelectNameOption> {
  String? color;
  List<Map<String, dynamic>>? selectedProductListByColor = [];
  Map<String, dynamic>? selectedProduct;
  String? size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40, right: 16, left: 16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(),
                ),
                child: DropdownButtonHideUnderline(
                  child: Obx(
                    () => DropdownButton2<String?>(
                      hint: const Text(
                        '색상 선택',
                        style: TextStyle(fontSize: 16),
                      ),
                      isExpanded: true,
                      value: color,
                      items: widget.controller.productMasterColorOptionList
                          .map(
                            (color) => DropdownMenuItem(
                              value: color,
                              child: Text(
                                color,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(
                          () {
                            color = value;
                            selectedProductListByColor = widget.controller
                                .selectColorOptionInName(value!);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              selectedProductListByColor!.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String?>(
                          hint: const Text(
                            '사이즈 선택',
                            style: TextStyle(fontSize: 16),
                          ),
                          isExpanded: true,
                          value: size,
                          items: List<String>.from(selectedProductListByColor!
                                  .map((product) =>
                                      product['size'] +
                                      (product['priceAdditional'] != 0
                                          ? '(+${formatMoney(product['priceAdditional'])})'
                                          : '')))
                              .map(
                                (size) => DropdownMenuItem(
                                  value: size,
                                  child: Text(
                                    size,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            final selectedProduct = selectedProductListByColor!
                                .firstWhere((product) =>
                                    product['size'] == value?.split('(')[0] &&
                                    product['color'] == color);

                            for (SelectNameOption nameOption
                                in widget.controller.nameOptionList) {
                              if (nameOption
                                      .optionController.selectedProduct.value ==
                                  selectedProduct) {
                                return showSnackBar('이미 추가된 옵션입니다.');
                              }
                            }
                            setState(
                              () {
                                size = value;
                                widget.optionController.selectedProduct.value =
                                    selectedProduct;
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 8,
              ),
              Obx(() => widget.optionController.selectedProduct.value != null
                  ? SpeedOrderSelectNameAndQuantity(
                      controller: widget.optionController)
                  : Container()),
              const SizedBox(
                height: 16,
              ),
              const Row(
                children: [
                  DefaultText(
                    '요청사항',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              OutlinedTextField(
                minWidth: double.infinity,
                controller: widget.optionController.userRequest,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: () {
              widget.controller.removeNameOption(widget.optionController);
            },
            child: const FaIcon(
              FontAwesomeIcons.solidCircleX,
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}
