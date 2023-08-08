import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';

void showGetBottomSheet({
  required Widget bottomSheet,
}) =>
    Get.bottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      backgroundColor: backgroundColor,
      isScrollControlled: true,
      bottomSheet,
    );
