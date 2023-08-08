import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/widgets/ordered_product.dart';

class OrderedProductDetail extends StatelessWidget {
  const OrderedProductDetail({
    Key? key,
    required this.orderDetail,
  }) : super(key: key);

  final Map<String, dynamic> orderDetail;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultScreenPadding(
                  child: DefaultText('주문상품정보', style: Get.textTheme.bodySmall)),
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const FaIcon(
                      FontAwesomeIcons.x,
                      size: 18,
                    )),
              )
            ],
          ),
          OrderedProduct(orderDetail: orderDetail),
          const SizedBox(
            height: 10,
          ),
          DefaultScreenPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(
                  '요청사항',
                  style: Get.textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                if (orderDetail['userRequest'] != null)
                  DefaultText(
                    orderDetail['userRequest'],
                    style: Get.textTheme.labelLarge,
                  ),
                const Divider(
                  height: 40,
                ),
                orderDetail['draft'] != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            '시안',
                            style: Get.textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Image.network(orderDetail['draft']['image']),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultText(
                                    '작업비',
                                    style: Get.textTheme.labelMedium,
                                  ),
                                  DefaultText(
                                    formatMoney(orderDetail['priceWork']),
                                    style: Get.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              orderDetail['draft']['font'] != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DefaultText(
                                          '폰트',
                                          style: Get.textTheme.labelMedium,
                                        ),
                                        DefaultText(
                                          orderDetail['draft']['font'],
                                          style: Get.textTheme.bodyMedium,
                                        ),
                                      ],
                                    )
                                  : Container(),
                              orderDetail['draft']['threadColor'] != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DefaultText(
                                          '실색상',
                                          style: Get.textTheme.labelMedium,
                                        ),
                                        DefaultText(
                                          orderDetail['draft']['threadColor'],
                                          style: Get.textTheme.bodyMedium,
                                        ),
                                      ],
                                    )
                                  : Container()
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DefaultText(
                            '이름',
                            style: Get.textTheme.labelMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            runSpacing: 0,
                            children: [
                              for (var name in orderDetail['studentNames'])
                                Padding(
                                  padding: const EdgeInsets.only(right: 3.0),
                                  child: Chip(
                                    label: DefaultText(
                                      name,
                                      style: Get.textTheme.labelMedium,
                                    ),
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
