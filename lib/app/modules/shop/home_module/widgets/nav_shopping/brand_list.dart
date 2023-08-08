import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_shopping_controller.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/nav_shopping/brand_item.dart';

class BrandList extends StatelessWidget {
  const BrandList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 2)
        ],
      ),
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Obx(
        () => ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: ShopNavShoppingController.to.brandList.length,
          itemBuilder: (context, index) {
            return BrandItem(
                brand: ShopNavShoppingController.to.brandList[index]);
          },
        ),
      ),
    );
  }
}
