import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/product_name.dart';

class OrderingProducts extends StatelessWidget {
  const OrderingProducts({Key? key, required this.orderMaster})
      : super(key: key);

  final Map<String, dynamic> orderMaster;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultText(
          '주문상품',
          style: Get.textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 20,
        ),
        for (var detail in orderMaster['details'])
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.network(
                      detail['product']['productMaster']['thumbnail'],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductName(
                            product: detail['product']['productMaster']),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                DefaultText(
                                  detail['product']['color'],
                                  style: Get.textTheme.labelLarge,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DefaultText(
                                  detail['product']['size'],
                                  style: Get.textTheme.labelLarge,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DefaultText(
                                  '${detail['quantity']}개',
                                  style: Get.textTheme.labelLarge,
                                ),
                              ],
                            ),
                            DefaultText(formatMoney(detail['priceTotal'])),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        const Divider(
          height: 40,
        ),
      ],
    );
  }
}
