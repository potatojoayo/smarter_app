import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ClassPaymentDetailController extends GetxController {
  static ClassPaymentDetailController get to => Get.find();

  final priceToPay = TextEditingController();
  final memo = TextEditingController();
}
