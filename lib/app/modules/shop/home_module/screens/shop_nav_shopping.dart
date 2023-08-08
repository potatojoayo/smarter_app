import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_shopping_controller.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/nav_shopping/brand_list.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/nav_shopping/category_list.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/nav_shopping/sub_category_list.dart';
import 'package:smarter/app/modules/shop/product_module/product_query.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/product_grid.dart';

class ShopNavShopping extends StatelessWidget {
  const ShopNavShopping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          const CategoryList(),
          const SizedBox(
            height: 8,
          ),
          const SubCategoryList(),
          const SizedBox(
            height: 8,
          ),
          const BrandList(),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => ShopNavShoppingController.to.isLoading.value
                    ? Container()
                    : Query(
                        options: QueryOptions(
                            document: gql(ProductQuery.productMasters),
                            fetchPolicy: FetchPolicy.cacheAndNetwork,
                            variables: {
                              'category': ShopNavShoppingController
                                  .to.selectedCategory.value,
                              'subCategory': ShopNavShoppingController
                                  .to.selectedSubCategory.value,
                              'brand': ShopNavShoppingController
                                  .to.selectedBrand.value
                            }),
                        builder: (result, {fetchMore, refetch}) {
                          if (result.hasException) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(result.exception.toString())),
                              ),
                            );
                          }

                          if (result.isLoading) {
                            return SizedBox(
                              height: 300,
                              child: Center(
                                child: SpinKitChasingDots(
                                  color: Get.theme.primaryColorDark,
                                ),
                              ),
                            );
                          }

                          List productMasters = result.data!['productMasters']
                                  ['edges']
                              .map((e) => e['node'])
                              .toList();

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: ProductGrid(
                              products: productMasters,
                              title: '',
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
