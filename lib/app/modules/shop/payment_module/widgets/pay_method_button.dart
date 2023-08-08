import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/payment_module/mixins/payment_mixin.dart';

class PayMethodButton extends StatelessWidget {
  const PayMethodButton(
      {Key? key, required this.method, required this.controller})
      : super(key: key);

  final PaymentMixin controller;
  final String method;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.selectedMethod = method;
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: controller.selectedMethod != null &&
                      controller.selectedMethod == method
                  ? Get.theme.primaryColorDark
                  : textColor,
            ),
            borderRadius: BorderRadius.circular(10),
            color: controller.selectedMethod != null &&
                    controller.selectedMethod == method
                ? Get.theme.primaryColorDark
                : backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              FaIcon(
                method == '무통장입금'
                    ? FontAwesomeIcons.solidMoneyCheckDollar
                    : FontAwesomeIcons.creditCard,
                color: controller.selectedMethod != null &&
                        controller.selectedMethod == method
                    ? backgroundColor
                    : textColor,
              ),
              Obx(
                () => DefaultText(
                  method,
                  style: TextStyle(
                      color: controller.selectedMethod != null &&
                              controller.selectedMethod == method
                          ? backgroundColor
                          : textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
