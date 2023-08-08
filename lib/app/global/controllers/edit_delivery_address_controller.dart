import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:smarter/app/modules/auth_module/widgets/address_web_view.dart';

class EditDeliveryAddressController extends GetxController {
  static EditDeliveryAddressController get to => Get.find();

  final isDefault = false.obs;

  final phoneFormatter = MaskTextInputFormatter(
      mask: '### - #### - ####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void onInit() {
    try {
      final address = Get.arguments['address'];
      addressId = int.parse(address['id']);
      addressNameController.text = address['name'];
      receiverController.text = address['receiver'];
      phoneController.text = phoneFormatter.maskText(address['phone']);
      zipCodeController.text = address['zipCode'];
      addressController.text = address['address'];
      detailAddressController.text = address['detailAddress'];
      isDefault.value = address['default'];
    } catch (_) {}
    super.onInit();
  }

  final addressNameController = TextEditingController();
  final receiverController = TextEditingController();
  final phoneController = TextEditingController();
  final zipCodeController = TextEditingController();
  final addressController = TextEditingController();
  final detailAddressController = TextEditingController();
  int? addressId;

  Future<void> showAddressBottomSheet() async {
    final data = await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: false,
        builder: (context) {
          return const AddressWebView();
        });
    final mappedData = json.decode(data);
    zipCodeController.text = mappedData['zonecode'];
    addressController.text = mappedData['roadAddress'];
  }
}
