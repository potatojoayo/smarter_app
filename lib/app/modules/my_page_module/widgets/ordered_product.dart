import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/utils/get_icon.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/widgets/change_button.dart';
import 'package:smarter/app/modules/my_page_module/widgets/change_info_button.dart';
import 'package:smarter/app/modules/my_page_module/widgets/delivery_info_button.dart';
import 'package:smarter/app/modules/my_page_module/widgets/ordered_product_detail.dart';
import 'package:smarter/app/modules/my_page_module/widgets/return_button.dart';
import 'package:smarter/app/routes/routes.dart';

class OrderedProduct extends StatelessWidget {
  const OrderedProduct({
    Key? key,
    required this.orderDetail,
    this.orderId,
    this.refetch,
  }) : super(key: key);

  final Map<String, dynamic> orderDetail;
  final String? orderId;
  final Function? refetch;

  @override
  Widget build(BuildContext context) {
    return DefaultScreenPadding(
      child: InkWell(
        onTap: () async {
          if (Get.routing.isBottomSheet!) {
            return;
          }
          if (Get.routing.current.contains(Routes.orderDetail)) {
            Get.bottomSheet(
                Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: OrderedProductDetail(
                    orderDetail: orderDetail,
                  ),
                ),
                backgroundColor: Colors.transparent,
                isScrollControlled: true);
            return;
          }
          if (orderId != null) {
            await Get.toNamed('${Routes.orderDetail}/$orderId');
            refetch!();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                orderDetail['draft'] != null
                    ? Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.yellow[400],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DefaultText(
                          '로고마킹',
                          style: Get.textTheme.labelMedium,
                        ),
                      )
                    : Container(),
                const SizedBox(
                  width: 10,
                ),
                if (orderDetail['state'].contains('교환'))
                  ChangeInfoButton(orderDetail: orderDetail),
                if (orderDetail['delivery'] != null &&
                    orderDetail['state'].contains('배송'))
                  DeliveryInfoButton(orderDetail: orderDetail),
                const SizedBox(
                  width: 8,
                ),
                FaIcon(
                  getIcon(orderDetail['state']),
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                DefaultText(
                  orderDetail['state'],
                  style: Get.textTheme.labelLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    orderDetail['product']['productMaster']['thumbnail'],
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        orderDetail['product']['productMaster']['name'],
                        overflow: TextOverflow.visible,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        direction: Axis.horizontal,
                        spacing: 20,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                '색상',
                                style: Get.textTheme.labelSmall,
                              ),
                              DefaultText(
                                orderDetail['product']['color'],
                                style: Get.textTheme.labelLarge,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                '사이즈',
                                style: Get.textTheme.labelSmall,
                              ),
                              DefaultText(
                                orderDetail['product']['size'],
                                style: Get.textTheme.labelLarge,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                '개수',
                                style: Get.textTheme.labelSmall,
                              ),
                              DefaultText(
                                orderDetail['quantity'].toString(),
                                style: Get.textTheme.labelLarge,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                '가격',
                                style: Get.textTheme.labelSmall,
                              ),
                              DefaultText(
                                formatMoney(orderDetail['priceTotal']),
                                style: Get.textTheme.labelLarge,
                              ),
                            ],
                          ),
                          if ( orderDetail['studentNames'] != null && orderDetail['studentNames'].length > 0)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '학생이름',
                                  style: Get.textTheme.labelSmall,
                                ),
                                DefaultText(
                                  orderDetail['studentNames'].join(', '),
                                  style: Get.textTheme.labelLarge,
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Get.routing.current.contains(Routes.orderDetail) &&
                              !Get.routing.isBottomSheet! &&
                              ['배송중', '배송완료'].contains(orderDetail['state'])
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ChangeButton(
                                    orderDetail: orderDetail,
                                    refetch: refetch!),
                                const SizedBox(
                                  width: 8,
                                ),
                                ReturnButton(
                                  orderDetail: orderDetail,
                                  refetch: refetch!,
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
