import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_controller.dart';

class LogoAndName extends StatelessWidget {
  const LogoAndName({Key? key, required this.controller}) : super(key: key);

  final SpeedOrderItemController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            const Text('로고'),
            Obx(
              () => Switch(
                value: controller.useDraft,
                onChanged: (value) {
                  controller.useDraft = value;
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text('이름'),
            Obx(
              () => Switch(
                  value: controller.useName,
                  onChanged: (value) {
                    controller.useName = value;
                    controller.refreshUseName();
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
