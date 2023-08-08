import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/address_query.dart';
import 'package:smarter/app/modules/my_page_module/widgets/ordered_product.dart';
import 'package:smarter/app/modules/my_page_module/controllers/return_controller.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/order_delivery_info.dart';

class ReturnScreen extends GetView<ReturnController> {
  const ReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: DefaultText(
            '반품',
            style: Get.textTheme.titleSmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Query(
              options: QueryOptions(document: gql(AddressQuery.myAddresses)),
              builder: (result, {refetch, fetchMore}) {
                if (result.isLoading) {
                  return const SizedBox.shrink();
                }
                final addresses = List<Map<String, dynamic>>.from(
                    result.data!['myAddresses']);
                controller.selectedAddress.value =
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
                        '반품할 상품 개수',
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
                      Align(
                          alignment: Alignment.centerLeft,
                          child: DefaultText(
                            '사유',
                            style: Get.textTheme.labelLarge,
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
                      Align(
                          alignment: Alignment.centerLeft,
                          child: DefaultText(
                            '상품 회수지',
                            style: Get.textTheme.labelLarge,
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      DeliveryAddressInfo(
                          addresses: addresses,
                          address: controller.selectedAddress,
                          selectable: true,
                          onSelect: (address) =>
                              controller.selectedAddress.value = address,
                          type: 'return'),
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
                                '반품신청',
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
