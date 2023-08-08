import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/select_quantity.dart';

class SelectNameAndQuantity extends StatelessWidget {
  const SelectNameAndQuantity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultText(
          '이름',
          style: Get.textTheme.labelLarge,
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
            ProductController.to.studentNames
                .add({'name': name, 'count': 1.obs});
            ProductController.to.quantity += 1;
            ProductController.to.quantityController.text =
                ProductController.to.quantity.toString();
            textEditingController.clear();
          },
          style: const TextStyle(fontSize: 17),
        ),
        Obx(
          () => Wrap(
            runSpacing: -5,
            children: [
              for (var i = 0; i < ProductController.to.studentNames.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 3.0),
                  child: Chip(
                    label: DefaultText(
                      ProductController.to.studentNames[i]['name'],
                      style: Get.textTheme.labelMedium,
                    ),
                    deleteIcon: const FaIcon(
                      FontAwesomeIcons.x,
                      size: 12,
                    ),
                    onDeleted: () {
                      ProductController.to.studentNames.removeAt(i);
                      ProductController.to.quantity -= 1;
                      ProductController.to.quantityController.text =
                          ProductController.to.quantity.toString();
                    },
                  ),
                )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const SelectQuantity(),
      ],
    );
  }
}
