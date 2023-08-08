import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  static ChangePasswordController get to => Get.find();

  final currentPassword = TextEditingController();
  final changingPassword = TextEditingController();
  final checkPassword = TextEditingController();

  change() {}
}
