import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_controller.dart';

class SelectColor extends StatelessWidget {
  const SelectColor({Key? key, required this.controller}) : super(key: key);

  final SpeedOrderItemController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        width: double.infinity,
        child: Obx(() => !controller.useName
            ? ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: controller.productMasterColorOptionList.length,
                itemBuilder: (BuildContext context, int index) {
                  final color = controller.productMasterColorOptionList[index];
                  return GestureDetector(
                    onTap: () {
                      controller.selectColorOption(color);
                    },
                    child: Obx(
                      () => Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: controller.isSelectedColor(color).value
                                ? Get.theme.primaryColorDark
                                : Colors.white,
                            border: Border.all(
                              color: controller.isSelectedColor(color).value
                                  ? Get.theme.primaryColorDark
                                  : Colors.grey[700]!,
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: DefaultText(
                            color,
                            style: TextStyle(
                                fontSize: 16,
                                color: controller.isSelectedColor(color).value
                                    ? Colors.white
                                    : Colors.grey[700]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 4,
                  );
                },
              )
            : Container()));
  }
}
