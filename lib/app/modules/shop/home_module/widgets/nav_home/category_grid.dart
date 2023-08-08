import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_home_controller.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_home_controller.dart';
import 'package:smarter/app/modules/shop/product_module/product_query.dart';
import 'package:smarter/app/routes/routes.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(ProductQuery.categories),
          fetchPolicy: FetchPolicy.cacheAndNetwork),
      builder: (QueryResult<Object?> result,
          {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
          Future<QueryResult<Object?>?> Function()? refetch}) {
        if (result.isLoading) {
          return Container();
        }
        List? categoryList = result.data!['categories'];

        if (categoryList == null) {
          return Container();
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 160,
          width: double.infinity,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await Get.toNamed(Routes.shopShopping,
                      arguments: {'category': categoryList[index]}, id: 1);
                  ShopHomeController.to.currentIndex.value = 0;
                },
                child: Column(
                  children: [
                    Image.asset(
                      ShopNavHomeController.to
                          .getCategoryImage(categoryList[index]['name']),
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      categoryList[index]['name'],
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: categoryList.length,
          ),
        );
      },
    );
  }
}
