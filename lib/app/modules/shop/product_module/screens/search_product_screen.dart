import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/home_app_bar.dart';
import 'package:smarter/app/modules/shop/product_module/product_query.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/product_grid.dart';

class SearchProductScreen extends StatelessWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const HomeAppBar(),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Obx(
                () => Query(
                  options: QueryOptions(
                      document: gql(ProductQuery.productMasters),
                      variables: const {
                        // 'name': ShopHomeController.to.searchKeyword,
                        // 'first': 10
                      }),
                  builder: (result, {fetchMore, refetch}) {
                    if (result.hasException) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Center(child: Text(result.exception.toString())),
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

                    List? productMasters = result.data!['productMasters']
                            ['edges']
                        .map((e) => e['node'])
                        .toList();

                    if (productMasters == null) {
                      return const Text('상품이 비었습니다.');
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ProductGrid(
                        products: productMasters,
                        title: '',
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
      // floatingActionButton: const KakaoFloatingActionButton(),
    );
  }
}
