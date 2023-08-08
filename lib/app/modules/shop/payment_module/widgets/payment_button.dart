import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/order_controller.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/payment_bottom_sheet.dart';
import 'package:smarter/app/modules/shop/payment_module/mixins/payment_mixin.dart';

class PaymentButton extends StatefulWidget {
  const PaymentButton({Key? key, required this.controller}) : super(key: key);
  final PaymentMixin controller;

  @override
  State<PaymentButton> createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      height: 50,
      child: GestureDetector(
        onTap: () async {
          if (loading) {
            return;
          }
          if (!widget.controller.agreed) {
            return showSnackBar('결제를 하시려면 약관에 동의를 하셔야합니다.');
          }
          if (widget.controller.priceToPay > 0) {
            await Get.bottomSheet(
              PayBottomSheet(
                controller: widget.controller,
              ),
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
            );
            widget.controller.selectedMethod = null;
          } else {
            setState(() {
              loading = true;
            });
            await OrderController.to.pay();
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
                : Obx(
                    () => DefaultText(
                      '${widget.controller.priceToPay > 0 ? formatMoney(widget.controller.priceToPay) : '스마터머니로'} 결제하기',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
