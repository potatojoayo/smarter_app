import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_shopping_controller.dart';

class BrandItem extends StatelessWidget {
  const BrandItem({
    Key? key,
    required this.brand,
  }) : super(key: key);

  final String brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await ShopNavShoppingController.to.changeBrand(brand);
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ShopNavShoppingController.to.selectedBrand.value == brand
                ? Get.theme.primaryColorDark
                : Colors.transparent,
          ),
          child: Center(
            child: DefaultText(
              brand,
              style: TextStyle(
                fontSize: 16,
                color: ShopNavShoppingController.to.selectedBrand.value == brand
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
