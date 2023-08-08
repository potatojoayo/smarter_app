import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/routes/routes.dart';

showEventBottomSheet() {
  if (Get.routing.isBottomSheet!) {
    return;
  }

  Get.bottomSheet(
    GestureDetector(
      onTap: () {
        Get.back();
        Get.toNamed(Routes.editMyInfo, arguments: {'event': true});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: const ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          child: Image(
            image: AssetImage('assets/info_event.jpg'),
          ),
        ),
      ),
    ),
    enterBottomSheetDuration: const Duration(milliseconds: 500),
    backgroundColor: Colors.transparent,
  );
}
