import 'package:flutter/material.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/nav_home/banner_carousel.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/nav_home/category_grid.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/nav_home/notice.dart';
import 'package:smarter/app/modules/shop/product_module/product_query.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/product_masters.dart';

class ShopNavHome extends StatefulWidget {
  const ShopNavHome({Key? key}) : super(key: key);

  @override
  State<ShopNavHome> createState() => _ShopNavHomeState();
}

class _ShopNavHomeState extends State<ShopNavHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: const SingleChildScrollView(
        child: Column(
          children: [
            BannerCarousel(),
            SizedBox(
              height: 10,
            ),
            CategoryGrid(),
            Notice(),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 8,
              height: 0,
            ),
            ProductMasters(
              query: ProductQuery.recentOrderedProducts,
              title: '최근 주문하신 상품',
              queryName: 'recentOrderedProducts',
            ),
          ],
        ),
      ),
    );
  }
}
