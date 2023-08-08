import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/text.dart';

class CartedProductDraft extends StatelessWidget {
  const CartedProductDraft({
    Key? key,
    required this.draft,
  }) : super(key: key);

  final Map<String, dynamic> draft;

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
                child: Image.network(draft['image'])),
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
              formatMoney(draft['priceWork']),
              style: Get.textTheme.labelLarge,
            ),
          ],
        ),
      ],
    );
  }
}
