import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/color_select_button.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/product_name.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/select_quantity.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/size_select_button.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return DefaultScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductName(product: product),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      '${product['subCategory']['name']} | ${product['category']['name']}',
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.visible,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            DefaultText(
                              formatMoney(product['category']['name'] == '도복'
                                  ? product['priceGym'] + 3000
                                  : product['priceGym']),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const DefaultText(
                              '원',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        product['category']['name'] == '도복'
                            ? DefaultText(
                                "도복가 ${formatMoney(product['priceGym'])} 기본마킹비 ₩3,000",
                                style: TextStyle(
                                    color: Colors.grey.shade400, fontSize: 14),
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 40,
          ),
          DefaultText(
            '색상',
            style: Get.textTheme.labelLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          ColorSelectButton(
            product: product,
            controller: ProductController.to,
          ),
          const Divider(
            height: 32,
          ),
          DefaultText(
            '사이즈',
            style: Get.textTheme.labelLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          SizeSelectButton(product: product, controller: ProductController.to),
          const SelectQuantity(),
          const Divider(
            height: 40,
          ),
          DefaultText(
            '요청사항',
            style: Get.textTheme.labelLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: ProductController.to.userRequestController,
            autofocus: false,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: '요청사항을 입력해주세요.'),
            style: Get.textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}
