import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smarter/app/data/provider/artemis_client.dart';
import 'package:smarter/app/global/mixins/select_product_option_mixin.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/graphql_api.dart';

class ChangeController extends GetxController with SelectProductOptionMixin {
  static ChangeController get to => Get.find();
  late final Map<String, dynamic> orderDetail;
  final RxInt _quantity = 0.obs;

  @override
  void onInit() {
    super.onInit();
    orderDetail = Get.arguments['orderDetail'];
  }

  int get quantity => _quantity.value;

  set quantity(value) => _quantity.value = value;

  final pickUpAddress = Rx<Map<String, dynamic>?>(null);
  final deliveryAddress = Rx<Map<String, dynamic>?>(null);
  final reason = TextEditingController();

  createReturnOrder() async {
    if (pickUpAddress.value == null) {
      return showSnackBar('회수지를 선택해주세요.');
    }
    if (deliveryAddress.value == null) {
      return showSnackBar('배송지를 선택해주세요.');
    }
    if (quantity == 0) {
      return showSnackBar('교환하실 개수를 선택해주세요.');
    }
    if (selectedProductDetail == null) {
      return showSnackBar('교환하실 색상과 사이즈를 모두 선택해주세요.');
    }
    if (selectedProductDetail!['color'] == orderDetail['product']['color'] &&
        selectedProductDetail!['size'] == orderDetail['product']['size']) {
      return showSnackBar('주문하신 상품과 다른 옵션만 교환이 가능합니다.');
    }

    final client = Artemis().client;

    final result = await client.execute(
      CreateUserChangeRequestMutation(
        variables: CreateUserChangeRequestArguments(
          orderDetailId: int.parse(orderDetail['id']),
          quantity: quantity,
          changeReason: reason.text,
          pickUpAddress: pickUpAddress.value!['address'],
          pickUpDetailAddress: pickUpAddress.value!['detailAddress'],
          pickUpZipCode: pickUpAddress.value!['zipCode'],
          pickUpPhone: pickUpAddress.value!['phone'],
          pickUpReceiver: pickUpAddress.value!['receiver'],
          deliveryAddress: deliveryAddress.value!['address'],
          deliveryDetailAddress: deliveryAddress.value!['detailAddress'],
          deliveryZipCode: deliveryAddress.value!['zipCode'],
          deliveryPhone: deliveryAddress.value!['phone'],
          deliveryReceiver: deliveryAddress.value!['receiver'],
          changingProductId: selectedProductDetail!['productId'],
        ),
      ),
    );
    if (result.hasErrors) {
      return showSnackBar('교환요청 실패');
    }
    Get.back();
    showSnackBar(result.data!.createUserChangeRequest!.message!);
  }
}
