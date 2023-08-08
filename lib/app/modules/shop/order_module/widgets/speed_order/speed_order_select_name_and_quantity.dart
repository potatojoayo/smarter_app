import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_option_controller.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/speed_order/load_student_names.dart';

class SpeedOrderSelectNameAndQuantity extends StatelessWidget {
  const SpeedOrderSelectNameAndQuantity({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SpeedOrderItemOptionController controller;

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            DefaultText(
              '이름',
              style: Get.textTheme.labelLarge,
            ),
            LoadStudentNames(controller: controller),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: textEditingController,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintStyle: Get.textTheme.labelMedium,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hintText: "한명씩 입력후 완료 버튼을 눌러 추가해주세요."),
          onSubmitted: (name) {
            controller.studentNames.add({'name': name, 'count': 1.obs});
            controller.quantity += 1;
            controller.quantityController.text = controller.quantity.toString();
            textEditingController.clear();
          },
          style: const TextStyle(fontSize: 17),
        ),
        Obx(
          () => Wrap(
            runSpacing: -5,
            children: [
              for (var i = 0; i < controller.studentNames.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 3.0),
                  child: Chip(
                    label: DefaultText(
                      controller.studentNames[i]['name'],
                      style: Get.textTheme.labelMedium,
                    ),
                    deleteIcon: const FaIcon(
                      FontAwesomeIcons.x,
                      size: 12,
                    ),
                    onDeleted: () {
                      controller.studentNames.removeAt(i);
                      controller.quantity -= 1;
                      controller.quantityController.text =
                          controller.quantity.toString();
                    },
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
