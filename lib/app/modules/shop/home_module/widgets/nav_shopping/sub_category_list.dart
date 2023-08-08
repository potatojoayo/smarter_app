import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_shopping_controller.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/nav_shopping/sub_category_item.dart';

class SubCategoryList extends StatelessWidget {
  const SubCategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(
        () => ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: ShopNavShoppingController.to.subCategoryList.length,
          itemBuilder: (context, index) {
            return SubCategoryItem(
                category: ShopNavShoppingController.to.subCategoryList[index]);
          },
        ),
      ),
    );
  }
}
