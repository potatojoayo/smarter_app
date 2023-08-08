import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({Key? key, required this.order, required this.bankAccount})
      : super(key: key);

  final Map<String, dynamic> order;
  final Map<String, dynamic> bankAccount;

  @override
  Widget build(BuildContext context) {
    return DefaultScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            '결제정보',
            style: Get.textTheme.bodySmall,
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 30,
            runSpacing: 10,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '결제방법',
                    style: Get.textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  order['paymentRequest'] != null
                      ? DefaultText(
                          order['paymentRequest']['method'] ?? '-',
                          style: Get.textTheme.labelLarge,
                        )
                      : Container(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '결제날짜',
                    style: Get.textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DefaultText(
                    order['paymentSuccess'] != null
                        ? DateFormat('yyyy. MM. dd').format(DateTime.parse(
                            order['paymentSuccess']['requestedAt']))
                        : '미결제',
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '상품금액',
                    style: Get.textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DefaultText(
                    formatMoney(order['details']
                        .fold(0, (a, b) => a + b['priceProducts'])),
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '옵션 금액',
                    style: Get.textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DefaultText(
                    formatMoney(order['details']
                        .fold(0, (a, b) => a + b['priceOption'])),
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '작업비',
                    style: Get.textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DefaultText(
                    formatMoney(
                        order['details'].fold(0, (a, b) => a + b['priceWork'])),
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                '배송비',
                style: Get.textTheme.labelSmall,
              ),
              const SizedBox(
                height: 5,
              ),
              DefaultText(
                formatMoney(order['priceDelivery']),
                style: Get.textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                '합계 금액',
                style: Get.textTheme.labelSmall,
              ),
              const SizedBox(
                height: 5,
              ),
              DefaultText(
                formatMoney(order['paymentSuccess'] != null
                    ? order['paymentSuccess']['amount']
                    : order['paymentRequest']['amount']),
                style: Get.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                '스마터머니 사용',
                style: Get.textTheme.labelSmall,
              ),
              const SizedBox(
                height: 5,
              ),
              DefaultText(
                order['smarterMoneyHistory'] != null
                    ? '- ${formatMoney(order['smarterMoneyHistory']['amount'])}'
                    : '-',
                style: Get.textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (order['coupon'] != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(
                  '사용 쿠폰',
                  style: Get.textTheme.labelSmall,
                ),
                const SizedBox(
                  height: 5,
                ),
                DefaultText(
                  "${order['coupon']['couponName']} \n(- ${formatMoney(order['coupon']['price'])})",
                  style: Get.textTheme.labelLarge,
                ),
              ],
            ),
          const SizedBox(
            height: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                '결제할 금액',
                style: Get.textTheme.labelSmall,
              ),
              DefaultText(
                formatMoney(order['priceToPay']),
                style: TextStyle(color: Colors.red[300]),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          order['paymentRequest'] != null &&
                  order['paymentRequest']['method'] == '무통장입금'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      '무통장입금계좌',
                      style: Get.textTheme.labelSmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DefaultText(
                      '${bankAccount['bankName']} ${bankAccount['accountNo']} \n예금주: ${bankAccount['ownerName']}',
                      style: Get.textTheme.labelLarge,
                    ),
                  ],
                )
              : Container(),
          const SizedBox(
            height: 8,
          ),
          order['paymentSuccess'] != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      '총 결제 금액',
                      style: Get.textTheme.labelSmall,
                    ),
                    DefaultText(
                      formatMoney(order['priceToPay']),
                      style: Get.textTheme.bodyMedium,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
