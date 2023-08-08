import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/my_page_module/claim_mutation.dart';

class ClaimController extends GetxController {
  static ClaimController get to => Get.find();
  final _quantity = 0.obs;
  int get quantity => _quantity.value;
  set quantity(value) => _quantity.value = value;

  final reasonController = TextEditingController();

  requestClaim({required int orderDetailId, required String type}) async {
    if (quantity == 0) {
      return showSnackBar('개수를 입력해주세요.');
    }
    if (reasonController.text.isEmpty) {
      return showSnackBar('사유를 입력해주세요.');
    }
    final result = await Client().client.value.mutate(
          MutationOptions(
            document: gql(ClaimMutation.requestClaim),
            variables: {
              'orderDetailId': orderDetailId,
              'quantity': quantity,
              'type': type,
              'reason': reasonController.text
            },
          ),
        );
    if (result.data!['requestClaim']['success']) {
      Get.back();
      // Get.offNamedUntil(Routes.orderAndDelivery,
      //     (route) => route.settings.name == Routes.home);
    }
  }
}
