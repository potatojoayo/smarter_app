import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_shopping_controller.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Map<String, dynamic> category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await ShopNavShoppingController.to.changeCategory(category);
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: ShopNavShoppingController.to
                        .isSelectedCategory(category)
                        .value
                    ? Get.theme.primaryColorDark
                    : Colors.transparent,
              ),
            ),
          ),
          child: Center(
            child: DefaultText(
              '${category['name']}',
              style: TextStyle(
                fontSize: 16,
                color: ShopNavShoppingController.to
                        .isSelectedCategory(category)
                        .value
                    ? Get.theme.primaryColorDark
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
