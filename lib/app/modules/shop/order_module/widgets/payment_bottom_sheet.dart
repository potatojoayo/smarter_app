import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/select_pay_method.dart';
import 'package:smarter/app/modules/shop/payment_module/mixins/payment_mixin.dart';

class PayBottomSheet extends StatefulWidget {
  const PayBottomSheet({
    super.key,
    required this.controller,
  });

  final PaymentMixin controller;

  @override
  State<PayBottomSheet> createState() => _PayBottomSheetState();
}

class _PayBottomSheetState extends State<PayBottomSheet> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectPayMethod(controller: widget.controller),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              if (widget.controller.selectedMethod == '카드' &&
                  widget.controller.priceToPay < 1000) {
                loading = false;
                return showSnackBar('1,000원 미만의 주문은 카드를 사용하실 수 없습니다.');
              }
              if (!loading) {
                setState(() {
                  loading = true;
                });
                widget.controller.onPressedPayButton();
              }
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Get.theme.primaryColorDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: loading
                    ? const SpinKitRing(
                        color: Colors.white,
                        size: 24,
                        lineWidth: 4,
                      )
                    : DefaultText(
                        '${formatMoney(widget.controller.priceToPay)} 결제하기',
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
