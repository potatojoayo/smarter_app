import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/utils/money_formatter.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/order_controller.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/select_coupon.dart';
import 'package:smarter/app/modules/shop/smarter_money_module/controllers/smarter_money_controller.dart';
import 'package:smarter/graphql_api.graphql.dart';

class OrderPaymentInfo extends StatelessWidget {
  const OrderPaymentInfo(
      {Key? key,
      required this.orderMaster,
      required this.coupons,
      required this.didUseCouponToday})
      : super(key: key);

  final Map<String, dynamic> orderMaster;
  final List<OrderMasterAndAddresses$Query$CouponType> coupons;
  final bool didUseCouponToday;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              '결제정보',
              style: Get.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText(
                  '총 상품가격',
                  style: Get.textTheme.labelLarge,
                ),
                DefaultText(
                  formatMoney(orderMaster['details']
                      .fold(0, (a, b) => a + b['priceTotal'])),
                  style: Get.textTheme.labelLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText(
                  '총 배송비',
                  style: Get.textTheme.labelLarge,
                ),
                DefaultText(
                  '+ ${formatMoney(orderMaster['priceDelivery'])}',
                  style: Get.textTheme.labelLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText(
                  '총 금액',
                  style: Get.textTheme.labelLarge,
                ),
                DefaultText(
                  formatMoney(orderMaster['priceDelivery'] +
                      orderMaster['details']
                          .fold(0, (a, b) => a + b['priceTotal'])),
                  style: Get.textTheme.labelLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      '스마터머니 사용',
                      style: Get.textTheme.labelLarge,
                    ),
                    DefaultText(
                      '보유 스마터머니: ${formatMoney(SmarterMoneyController.to.balance)}',
                      style: Get.textTheme.labelSmall,
                    ),
                  ],
                ),
                OutlinedTextField(
                  formatter: moneyFormatter,
                  textAlign: TextAlign.right,
                  onChanged: (money) {
                    String replaced = money.replaceAll(RegExp(r'[^0-9]'), '');
                    if (replaced == '') {
                      replaced = '0';
                    }
                    int usingAmount = int.parse(replaced);
                    if (usingAmount > SmarterMoneyController.to.balance) {
                      usingAmount = SmarterMoneyController.to.balance;
                      OrderController.to.smarterMoneyController.value =
                          TextEditingValue(
                        text: moneyFormatter.format(usingAmount.toString()),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                            offset: OrderController.to.smarterMoneyController
                                    .selection.baseOffset -
                                1,
                          ),
                        ),
                      );
                    }
                    if (usingAmount > OrderController.to.priceTotal) {
                      usingAmount = OrderController.to.priceTotal -
                          (OrderController.to.selectedCoupon.value != null
                              ? OrderController.to.selectedCoupon.value!.price!
                              : 0);
                      OrderController.to.smarterMoneyController.value =
                          TextEditingValue(
                        text: moneyFormatter.format(usingAmount.toString()),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: OrderController.to.smarterMoneyController
                                      .selection.baseOffset -
                                  1),
                        ),
                      );
                    }

                    OrderController.to.usingSmarterMoney.value = usingAmount;
                  },
                  keyboardType: TextInputType.number,
                  controller: OrderController.to.smarterMoneyController,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SelectCoupon(
                coupons: coupons, didUseCouponToday: didUseCouponToday),
            const Divider(
              height: 30,
              color: textColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText(
                  '결제하실 금액',
                  style: Get.textTheme.bodySmall,
                ),
                Obx(
                  () => DefaultText(
                    formatMoney(OrderController.to.priceToPay),
                    style: Get.textTheme.bodySmall,
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
