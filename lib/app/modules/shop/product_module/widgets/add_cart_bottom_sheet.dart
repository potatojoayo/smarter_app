import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/base_bottom_sheet.dart';
import 'package:smarter/app/modules/shop/cart_module/controllers/cart_controller.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/product_detail.dart';

class AddCartBottomSheet extends StatelessWidget {
  const AddCartBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      bodyHeight: MediaQuery.of(context).size.height * 0.9 - 95,
      body: ListView(
        children: [
          ProductDetail(
            productDetail: ProductController.to.selectedProductDetail!,
            product: ProductController.to.product,
          ),
        ],
      ),
      bottom: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Get.theme.primaryColorDark,
                ),
                onPressed: () {
                  CartController.to.addToCart(
                    userRequest:
                        ProductController.to.userRequestController.text,
                    priceTotalWork: ProductController.to.priceTotalWork,
                    priceProducts: ProductController.to.priceProducts,
                    productDetail: ProductController.to.selectedProductDetail!,
                    product: ProductController.to.product,
                    quantity: ProductController.to.quantity,
                    draft: ProductController.to.selectedDraft,
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.solidCartShopping,
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '장바구니에 담기',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
