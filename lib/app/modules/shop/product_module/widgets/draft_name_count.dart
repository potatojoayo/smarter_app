import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';

class DraftNameCount extends StatelessWidget {
  const DraftNameCount({
    Key? key,
    required this.name,
  }) : super(key: key);

  final Map<String, dynamic> name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultText(
            name['name'],
            style: Get.textTheme.labelLarge,
          ),
          Row(
            children: [
              Obx(() => name['count'].value > 1
                  ? IconButton(
                      onPressed: () {
                        name['count'].value -= 1;
                        ProductController.to.quantity -= 1;
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.solidSquareMinus,
                        size: 17,
                        color: textColor,
                      ),
                    )
                  : Container()),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 20,
                width: 21,
                child: Center(
                  child: Obx(
                    () => DefaultText(
                      '${name['count'].value}',
                      style: Get.textTheme.labelLarge,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  name['count'].value += 1;
                  ProductController.to.quantity += 1;
                },
                icon: const FaIcon(
                  FontAwesomeIcons.solidSquarePlus,
                  size: 17,
                  color: textColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
