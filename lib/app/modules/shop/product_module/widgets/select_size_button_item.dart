import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';

class SelectSizeButtonItem extends StatelessWidget {
  const SelectSizeButtonItem({Key? key, required this.productDetail})
      : super(key: key);

  final Map<String, dynamic> productDetail;

  @override
  Widget build(BuildContext context) {
    return productDetail['state'] == '숨김'
        ? const SizedBox.shrink()
        : InkWell(
            onTap: () {
              if (ProductController.to.selectedColor == null) {
                showSnackBar('색상을 먼저 선택해주세요');
                return;
              }

              if (productDetail['state'] == '품절') {
                showSnackBar('선택하신 사이즈는 품절되었습니다.');
                return;
              }

              ProductController.to.selectedProductDetail = productDetail;
            },
            child: Obx(
              () => FittedBox(
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: ProductController.to.selectedColor == null ||
                            productDetail['state'] == '품절'
                        ? Colors.grey[300]
                        : ProductController.to.selectedProductDetail != null &&
                                ProductController
                                        .to.selectedProductDetail!['id'] ==
                                    productDetail['id']
                            ? textColor
                            : null,
                    border: Border.all(
                      color: textColor,
                    ),
                  ),
                  child: Center(
                    child: DefaultTextStyle(
                        style: TextStyle(
                          color: ProductController.to.selectedProductDetail !=
                                      null &&
                                  ProductController
                                          .to.selectedProductDetail!['id'] ==
                                      productDetail['id'] &&
                                  productDetail['state'] != '품절'
                              ? backgroundColor
                              : textColor,
                          fontSize: 15,
                        ),
                        child: DefaultText(productDetail['priceAdditional'] > 0
                            ? '${productDetail['size']} + ${formatMoney(productDetail['priceAdditional'])}'
                            : productDetail['size'])),
                  ),
                ),
              ),
            ),
          );
  }
}
