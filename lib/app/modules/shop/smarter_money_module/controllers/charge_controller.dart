import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/shop/payment_module/mixins/payment_mixin.dart';
import 'package:smarter/app/modules/shop/smarter_money_module/smarter_money_mutation.dart';
import 'package:smarter/app/routes/routes.dart';

class ChargeController extends GetxController with PaymentMixin {
  static ChargeController get to => Get.find();

  @override
  Future<void> onSuccess(String orderId) async {
    await Client().client.value.mutate(MutationOptions(
        document: gql(SmarterMoneyMutation.charge),
        variables: {"orderId": orderId}));
    Get.offNamedUntil(
        Routes.smarterMoney, (route) => route.settings.name == Routes.shop);
  }

  final amountController = TextEditingController();

  @override
  Future<void> pay() async {
    if (priceToPay == 0) {
      showSnackBar('충전하실 금액을 입력해주세요');
      return;
    }
    final result = await Client().client.value.mutate(MutationOptions(
            document: gql(SmarterMoneyMutation.createChargeRequest),
            variables: {
              'amount': priceToPay,
              'method': selectedMethod,
            }));
    if (result.data == null || result.data!['createChargeOrder'] == null) {
      loadingButtonController.stop();
      showSnackBar("에러");
      return;
    }
    final chargeOrder = result.data!['createChargeOrder']['chargeOrder'];
    if (selectedMethod == '무통장입금') {
      Get.offAndToNamed(Routes.notification);
    } else {
      showPayBottomSheet(
          orderId: chargeOrder['orderId'],
          orderName: chargeOrder['orderName'],
          amount: chargeOrder['amount']);
    }
  }
}
