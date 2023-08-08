import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String message,
    {Color color = const Color(
      0xFFEDEDED,
    ),
    double fontSize = 15,
    int duration = 2000}) {
  Get.snackbar('색상을 먼저 선택해주세요.', '',
      duration: Duration(milliseconds: duration),
      snackPosition: SnackPosition.BOTTOM,
      titleText: Center(
        child: Text(
          message,
          style: TextStyle(color: color, fontSize: fontSize),
        ),
      ),
      messageText: const SizedBox.shrink(),
      backgroundColor: const Color(0x99000000),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10));
}
