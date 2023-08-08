import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/controllers/change_controller.dart';
import 'package:smarter/app/modules/my_page_module/widgets/ordered_product.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/order_delivery_info.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/color_select_button.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/size_select_button.dart';
import 'package:smarter/graphql_api.dart';

class ChangeScreen extends GetView<ChangeController> {
  const ChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: DefaultText(
            '교환',
            style: Get.textTheme.titleSmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Query(
              options: QueryOptions(
                  document: MyAddressesAndProductMasterQuery(
                          variables: MyAddressesAndProductMasterArguments(
                              productMasterId: controller.orderDetail['product']
                                  ['productMaster']['productMasterId']))
                      .document,
                  variables: {
                    'productMasterId': controller.orderDetail['product']
                        ['productMaster']['productMasterId']
                  }),
              builder: (result, {refetch, fetchMore}) {
                if (result.isLoading) {
                  return const SizedBox.shrink();
                }
                final addresses = List<Map<String, dynamic>>.from(
                    result.data!['myAddresses']);
                final productMaster = result.data!['productMaster'];
                controller.pickUpAddress.value =
                    addresses.firstWhereOrNull((a) => a['default']);
                controller.deliveryAddress.value =
                    addresses.firstWhereOrNull((a) => a['default']);
                return Container(
                  color: Get.theme.colorScheme.background,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OrderedProduct(orderDetail: controller.orderDetail),
                      const Divider(
                        height: 24,
                      ),
                      const DefaultText(
                        '교환할 상품 개수',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Obx(() => Visibility(
                                  visible: controller.quantity > 0,
                                  child: IconButton(
                                    onPressed: () {
                                      controller.quantity -= 1;
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.lightChevronLeft,
                                      size: 20,
                                      color: textColor,
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 50,
                            child: Center(
                              child: Obx(
                                () => DefaultText(
                                  controller.quantity.toString(),
                                  style: Get.textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            child: Obx(() => Visibility(
                                  visible: controller.quantity <
                                      controller.orderDetail['quantity'],
                                  child: IconButton(
                                    onPressed: () {
                                      controller.quantity += 1;
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.lightChevronRight,
                                      size: 20,
                                      color: textColor,
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const DefaultText(
                        '교환할 색상',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ColorSelectButton(
                          product: productMaster, controller: controller),
                      const SizedBox(
                        height: 16,
                      ),
                      const DefaultText(
                        '교환할 사이즈',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizeSelectButton(
                          product: productMaster, controller: controller),
                      const SizedBox(
                        height: 16,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: DefaultText(
                            '사유',
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      OutlinedTextField(
                        controller: controller.reason,
                        minWidth: double.infinity,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: DefaultText(
                            '상품 회수지',
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      DeliveryAddressInfo(
                        addresses: addresses,
                        address: controller.pickUpAddress,
                        selectable: true,
                        onSelect: (address) =>
                            controller.pickUpAddress.value = address,
                        type: 'change/pickup',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: DefaultText(
                            '상품 배송지',
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      DeliveryAddressInfo(
                        addresses: addresses,
                        selectable: true,
                        address: controller.deliveryAddress,
                        onSelect: (address) =>
                            controller.deliveryAddress.value = address,
                        type: 'change/delivery',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        color: backgroundColor,
                        child: GestureDetector(
                          onTap: controller.createReturnOrder,
                          child: Container(
                            width: double.infinity,
                            height: 48,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Get.theme.primaryColorDark,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Center(
                              child: DefaultText(
                                '교환신청',
                                style: TextStyle(
                                    color: backgroundColor, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
