import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_controller.dart';
import 'package:smarter/app/modules/shop/product_module/product_query.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({Key? key, required this.controller}) : super(key: key);
  final SpeedOrderItemController controller;

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

          final categoryList =
              List<Map<String, dynamic>>.from(result.data?['categories']);
          final categoryNameList =
              List<String>.from(categoryList.map((c) => c['name']));

          controller.categoryList.assignAll(categoryList);

          return Column(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(5)),
              child: DropdownButtonHideUnderline(
                child: Obx(
                  () => DropdownButton2<String?>(
                    isExpanded: true,
                    dropdownMaxHeight: 400,
                    value: controller.selectedCategory,
                    hint: const DefaultText(
                      '카테고리 선택',
                      style: TextStyle(fontSize: 16),
                    ),
                    items: categoryNameList
                        .map(
                          (name) => DropdownMenuItem(
                            value: name,
                            child: Text(name,
                                style: const TextStyle(fontSize: 16)),
                          ),
                        )
                        .toList(),
                    onChanged: (String? value) {
                      controller.selectedCategory = value;
                    },
                  ),
                ),
              ),
            )
          ]);
        });
  }
}
