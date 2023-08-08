import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';
import 'package:smarter/app/modules/shop/payment_module/models/payment_request.dart';
import 'package:smarter/app/modules/shop/payment_module/widgets/payment_webview.dart';

mixin PaymentMixin on GetxController {
  final _selectedMethod = Rx<String?>(null);

  String? get selectedMethod => _selectedMethod.value;

  set selectedMethod(value) => _selectedMethod.value = value;

  final _agreed = RxBool(false);

  bool get agreed => _agreed.value;

  set agreed(value) => _agreed.value = value;

  final _priceToPay = 0.obs;

  int get priceToPay => _priceToPay.value;

  set priceToPay(value) => _priceToPay.value = value;

  final loadingButtonController = RoundedLoadingButtonController();

  final methods = [
    '무통장입금',
    '카드',
  ];

  @protected
  Future<void> showPayBottomSheet(
      {required String orderId,
      required String orderName,
      required int amount,
      int smarterMoney = 0}) async {
    await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isDismissible: false,
      builder: (context) {
        bool success = false;
        return WillPopScope(
          onWillPop: () async => false,
          child: PaymentWebView(
            title: '결제하기',
            paymentRequestUrl: _getPaymentRequest(
                    orderId: orderId,
                    orderName: orderName,
                    amount: amount,
                    smarterMoney: smarterMoney.toString())
                .url,
            onPageStarted: (url) {},
            onSuccess: () => onSuccess(orderId),
            onPageFinished: (url) async {
              if (url.contains('code=PAY_PROCESS_CANCELED')) {
                loadingButtonController.stop();
                Get.back(result: false);
                Get.back();
              }
            },
            onDisposed: () {},
            onTapCloseButton: () {
              Get.back(result: success);
              Get.back(result: success);
            },
            onWebViewCreated: (controller) {},
          ),
        );
      },
    );
  }

  @protected
  Future<void> pay();

  Future<void> onPressedPayButton() async {
    await pay();
  }

  Future<void> cancel() async {}

  PaymentRequest _getPaymentRequest(
      {required String orderId,
      required String orderName,
      required int amount,
      required String smarterMoney,
      int? couponId}) {
    switch (selectedMethod) {
      case '카드':
        return PaymentRequest.card(
            amount: amount,
            orderId: orderId,
            orderName: orderName,
            smarterMoney: smarterMoney,
            couponId: couponId,
            customerName: AuthController.to.user!['name']);
      case '계좌이체':
      default:
        return PaymentRequest.transfer(
          amount: amount,
          orderId: orderId,
          orderName: orderName,
          smarterMoney: smarterMoney,
          couponId: couponId,
          customerName: AuthController.to.user!['name'],
          bank: '신한',
        );
    }
  }

  void onSuccess(String orderId);
}
