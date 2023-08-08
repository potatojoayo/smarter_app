import 'package:get/get.dart';
import 'package:flutter/material.dart';

getAttendanceColor(String? type) {
  switch (type) {
    case null:
      return Colors.grey[600];
    case '등원':
      return Colors.green[600];
    case '타수업등원':
      return Colors.blue[600];
    case '하원':
      return Colors.yellow[800];
    case '결석':
      return Get.theme.colorScheme.error;
    default:
      return Colors.grey[600];
  }
}
