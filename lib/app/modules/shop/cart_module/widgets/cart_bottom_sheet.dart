import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/base_bottom_sheet.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/cart_module/controllers/cart_controller.dart';
import 'package:smarter/app/modules/shop/cart_module/widgets/carted_product_detail.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({Key? key}) : super(key: key);

  @override
  BaseBottomSheet build(BuildContext context) {
    return BaseBottomSheet(
      bodyHeight: MediaQuery.of(context).size.height * 0.9 - 133,
      top: Column(
        children: [
          Obx(
            () => DefaultScreenPadding(
              child: CartController.to.cartedProducts.isEmpty
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Obx(
                                () => Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                  onChanged: (value) {
                                    for (var product
                                        in CartController.to.cartedProducts) {
                                      product['checked'].value = value;
                                    }
                                  },
                                  value: CartController.to.checkedCount ==
                                      CartController.to.totalCount,
                                ),
                              ),
                            ),
                            Obx(
                              () => DefaultText(
                                '전체선택 (${CartController.to.checkedCount}/${CartController.to.totalCount})',
                                style: Get.textTheme.labelLarge,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                            onTap: CartController.to.deleteChecked,
                            child: const DefaultText(
                              '삭제',
                              style: TextStyle(color: errorColor, fontSize: 17),
                            ))
                      ],
                    ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            thickness: 1,
            height: 0,
          ),
        ],
      ),
      body: Obx(
        () => CartController.to.cartedProducts.isEmpty
            ? ListView(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: const Center(child: Text('장바구니가 비었습니다.')))
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () => ListView.separated(
                        separatorBuilder: (_, __) => const Divider(
                          thickness: 10,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: CartController.to.cartedProducts.length,
                        itemBuilder: (context, index) {
                          final cartedProduct =
                              CartController.to.cartedProducts[index];
                          return DefaultScreenPadding(
                            enableHorizontal: false,
                            vertical: 20,
                            child: CartedProductDetail(
                              cartedProduct: cartedProduct,
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(
                      height: 16,
                      thickness: 16,
                    ),
                    Column(
                      children: [
                        DefaultScreenPadding(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DefaultText(
                                '방문 수령',
                                style: Get.textTheme.labelLarge,
                              ),
                              Transform.scale(
                                scale: 1.2,
                                child: Obx(
                                  () => Checkbox(
                                    value: CartController.to.isPickUp.value,
                                    onChanged: (value) {
                                      CartController.to.isPickUp.value = value!;
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          height: 10,
                        ),
                        DefaultScreenPadding(
                          vertical: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DefaultText(
                                '총 금액',
                                style: Get.textTheme.bodyMedium,
                              ),
                              Obx(
                                () => DefaultText(
                                  formatMoney(CartController.to.priceTotal),
                                  style: Get.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
      bottom: CartController.to.cartedProducts.isEmpty
          ? Container()
          : Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        '총 금액',
                        style: Get.textTheme.labelMedium,
                      ),
                      Obx(
                        () => DefaultText(
                          formatMoney(CartController.to.priceTotal),
                          style: Get.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Obx(
                      () => SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CartController.to.checkedCount > 0
                                ? Get.theme.primaryColorDark
                                : Get.theme.disabledColor,
                          ),
                          onPressed: CartController.to.order,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.solidCreditCard,
                                size: 16,
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Text(
                                '구매하기',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
