import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/payment_module/mixins/payment_mixin.dart';

class PayAgreement extends StatelessWidget {
  const PayAgreement({Key? key, required this.controller}) : super(key: key);

  final PaymentMixin controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: Obx(
                  () => Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: controller.agreed,
                      onChanged: (value) {
                        controller.agreed = value;
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => controller.agreed = !controller.agreed,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DefaultText(
                    '구매조건 및 결제진행 동의',
                    style: Get.textTheme.labelLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: textColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: DefaultText(
                '주문하실 상품, 가격, 배송정보, 할인내역 등을 최종 확인하였으며, 구매 진행에 동의하시겠습니까? (전자상거래법 제 8조 2항)',
                overflow: TextOverflow.visible,
                style: Get.textTheme.labelLarge,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
