import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smarter/app/data/provider/artemis_client.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/graphql_api.dart';

class ReturnController extends GetxController {
  static ReturnController get to => Get.find();
  late final Map<String, dynamic> orderDetail;
  final RxInt _quantity = 0.obs;

  @override
  void onInit() {
    super.onInit();
    orderDetail = Get.arguments['orderDetail'];
  }

  int get quantity => _quantity.value;

  set quantity(value) => _quantity.value = value;

  final selectedAddress = Rx<Map<String, dynamic>?>(null);

  final reason = TextEditingController();

  createReturnOrder() async {
    if (selectedAddress.value == null) {
      return showSnackBar('주소를 선택해주세요.');
    }
    if (quantity == 0) {
      return showSnackBar('반품하실 개수를 선택해주세요.');
    }
    final client = Artemis().client;

    final result = await client.execute(
      CreateUserReturnRequestMutation(
        variables: CreateUserReturnRequestArguments(
          orderDetailId: int.parse(orderDetail['id']),
          quantity: quantity,
          returnReason: reason.text,
          address: selectedAddress.value!['address'],
          detailAddress: selectedAddress.value!['detailAddress'],
          zipCode: selectedAddress.value!['zipCode'],
          phone: selectedAddress.value!['phone'],
          receiver: selectedAddress.value!['receiver'],
        ),
      ),
    );
    if (result.hasErrors) {
      return showSnackBar('반품요청 실패');
    }
    Get.back();
    showSnackBar(result.data!.createUserReturnRequest!.message!);
  }
}
