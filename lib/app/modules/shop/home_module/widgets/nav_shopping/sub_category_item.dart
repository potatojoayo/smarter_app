import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_shopping_controller.dart';

class SubCategoryItem extends StatelessWidget {
  const SubCategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Map<String, dynamic> category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await ShopNavShoppingController.to.changeSubCategory(category['name']);
      },
      child: Obx(
        () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 2,
                color: ShopNavShoppingController.to.selectedSubCategory.value ==
                        category['name']
                    ? Get.theme.primaryColorDark
                    : Colors.transparent,
              ),
            ),
            child: Center(
              child: DefaultText(
                '${category['name']}',
                style: TextStyle(
                  fontSize: 16,
                  color:
                      ShopNavShoppingController.to.selectedSubCategory.value ==
                              category['name']
                          ? Get.theme.primaryColorDark
                          : Colors.grey,
                ),
              ),
            )),
      ),
    );
  }
}
