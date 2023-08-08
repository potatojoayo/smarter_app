import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_phone.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Map<String, dynamic> order;

  @override
  Widget build(BuildContext context) {
    return DefaultScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            '배송지정보',
            style: Get.textTheme.bodySmall,
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 30,
            runSpacing: 10,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '받으시는분',
                    style: Get.textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DefaultText(
                    order['receiver'],
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '연락처',
                    style: Get.textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DefaultText(
                    formatPhone(order['phone']),
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '주소',
                    style: Get.textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DefaultText(
                    order['address'],
                    style: Get.textTheme.labelLarge,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '상세주소',
                    style: Get.textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DefaultText(
                    order['detailAddress'],
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '배송요청사항',
                    style: Get.textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DefaultText(
                    order['deliveryRequest'] ?? '-',
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
