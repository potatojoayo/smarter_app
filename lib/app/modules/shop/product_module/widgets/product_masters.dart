import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/modules/shop/product_module/product_query.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/product_grid.dart';

class ProductMasters extends StatelessWidget {
  const ProductMasters(
      {Key? key,
      this.variables = const {},
      required this.title,
      this.query,
      this.queryName})
      : super(key: key);

  final Map<String, dynamic> variables;
  final String title;
  final String? query;
  final String? queryName;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(query ?? ProductQuery.productMasters),
        variables: variables,
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(result.exception.toString())),
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

        List? productMasters = result.data![queryName ?? 'productMasters']
                ['edges']
            .map((e) => e['node'])
            .toList();

        if (productMasters == null) {
          return const Text('상품이 비었습니다.');
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ProductGrid(
            products: productMasters,
            title: title,
          ),
        );
      },
    );
  }
}
