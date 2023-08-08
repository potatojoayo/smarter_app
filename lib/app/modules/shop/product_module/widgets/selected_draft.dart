import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/draft_name_count.dart';
import 'package:smarter/app/global/widgets/text.dart';

class SelectedDraft extends StatelessWidget {
  const SelectedDraft({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              '작업 시안',
              style: Get.textTheme.labelLarge,
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Image.network(
                    ProductController.to.selectedDraft!['image'])),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DefaultText(
              '작업비',
              style: Get.textTheme.labelLarge,
            ),
            DefaultText(
              formatMoney(ProductController.to.selectedDraft!['priceWork']),
              style: Get.textTheme.labelLarge,
            ),
          ],
        ),
        const Divider(
          height: 20,
        ),
        for (var name in ProductController.to.studentNames)
          DraftNameCount(
            name: name,
          ),
        const Divider(
          height: 30,
        ),
      ],
    );
  }
}
