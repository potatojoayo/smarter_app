import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/cart_module/widgets/carted_names.dart';
import 'package:smarter/app/modules/shop/cart_module/widgets/carted_product_draft.dart';
import 'package:smarter/app/routes/routes.dart';

class CartedProductDetail extends StatelessWidget {
  const CartedProductDetail({
    Key? key,
    required this.cartedProduct,
  }) : super(key: key);

  final Map<String, dynamic> cartedProduct;

  @override
  Widget build(BuildContext context) {
    return DefaultScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Center(
                  child: Obx(
                    () => Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      onChanged: (value) {
                        cartedProduct['checked'].value = value;
                      },
                      value: cartedProduct['checked'].value,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.toNamed(
                    '${Routes.product}/${cartedProduct['product']['id']}',
                  );
                },
                child: Row(
                  children: [
                    SizedBox(
                      height: 70,
                      child:
                          Image.network(cartedProduct['product']['thumbnail']),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          cartedProduct['product']['brand']['name'],
                          style: Get.textTheme.labelMedium,
                        ),
                        DefaultText(
                          cartedProduct['product']['name'],
                          style: const TextStyle(fontSize: 15),
                        ),
                        DefaultText(
                          '${cartedProduct['product']['category']['name']} > ${cartedProduct['product']['subCategory']['name']}',
                          style: Get.textTheme.labelSmall,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '색상',
                    style: Get.textTheme.labelSmall,
                  ),
                  DefaultText(
                    cartedProduct['productDetail']['color'],
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '사이즈',
                    style: Get.textTheme.labelSmall,
                  ),
                  DefaultText(
                    cartedProduct['productDetail']['size'],
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
              if (cartedProduct['productDetail']['priceAdditional'] > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      '옵션 추가금액',
                      style: Get.textTheme.labelSmall,
                    ),
                    DefaultText(
                      formatMoney(
                          cartedProduct['productDetail']['priceAdditional']),
                      style: Get.textTheme.labelLarge,
                    ),
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '수량',
                    style: Get.textTheme.labelSmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DefaultText(
                        cartedProduct['quantity'].toString(),
                        style: Get.textTheme.labelLarge,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DefaultText(
                    '가격',
                    style: Get.textTheme.labelSmall,
                  ),
                  DefaultText(
                    formatMoney(cartedProduct['product']['priceGym']),
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          cartedProduct['draft'] != null
              ? CartedProductDraft(
                  draft: cartedProduct['draft'],
                )
              : const Divider(),
          cartedProduct['studentNames'].length > 0
              ? CartedNames(
                  names: cartedProduct['studentNames'],
                )
              : Container(),
          Visibility(
            visible: cartedProduct['userRequest'] != '',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(
                  '요청사항',
                  style: Get.textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                DefaultText(
                  cartedProduct['userRequest'],
                  style: Get.textTheme.labelLarge,
                ),
                const Divider(
                  height: 40,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    '합계',
                    style: Get.textTheme.labelMedium,
                  ),
                  DefaultText(
                    '총 ${cartedProduct['quantity']} 개의 상품',
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DefaultText(
                    '총 금액',
                    style: Get.textTheme.labelMedium,
                  ),
                  DefaultText(
                    formatMoney(cartedProduct['priceTotal']),
                    style: Get.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
