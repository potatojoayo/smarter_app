import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/selected_draft.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    Key? key,
    this.enableHorizontalPadding = true,
    required this.product,
    required this.productDetail,
  }) : super(key: key);

  final bool enableHorizontalPadding;
  final Map<String, dynamic> product;
  final Map<String, dynamic> productDetail;

  @override
  Widget build(BuildContext context) {
    return DefaultScreenPadding(
      enableHorizontal: enableHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 70,
                child: Image.network(product['thumbnail']),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    product['brand']['name'],
                    style: Get.textTheme.labelMedium,
                  ),
                  DefaultText(
                    product['name'],
                    style: const TextStyle(fontSize: 17),
                  ),
                  DefaultText(
                    '${product['category']['name']} > ${product['subCategory']['name']}',
                    style: Get.textTheme.labelSmall,
                  ),
                ],
              )
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
                    productDetail['color'],
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
                    productDetail['size'],
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
              productDetail['priceAdditional'] > 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          '옵션 추가금액',
                          style: Get.textTheme.labelSmall,
                        ),
                        DefaultText(
                          formatMoney(productDetail['priceAdditional']),
                          style: Get.textTheme.labelLarge,
                        ),
                      ],
                    )
                  : Container(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DefaultText(
                    '가격',
                    style: Get.textTheme.labelSmall,
                  ),
                  DefaultText(
                    formatMoney(product['priceGym']),
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ProductController.to.selectedDraft != null
              ? const SelectedDraft()
              : const Divider(
                  height: 40,
                ),
          Visibility(
            visible: ProductController.to.userRequestController.text != '',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DefaultText(
                  '요청사항',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                DefaultText(
                  ProductController.to.userRequestController.text,
                  style: Get.textTheme.labelLarge,
                ),
                const Divider(
                  height: 40,
                ),
              ],
            ),
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
                  Obx(
                    () => DefaultText(
                      '총 ${ProductController.to.quantity} 개의 상품',
                      style: Get.textTheme.labelLarge,
                    ),
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
                  Obx(
                    () => DefaultText(
                      formatMoney(ProductController.to.priceTotalProductDetail),
                      style: Get.textTheme.bodyMedium,
                    ),
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
