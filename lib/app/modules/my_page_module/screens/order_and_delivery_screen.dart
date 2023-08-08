import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/modules/my_page_module/widgets/order_list_item.dart';
import 'package:smarter/app/modules/shop/order_module/order_query.dart';

class OrderAndDeliveryScreen extends StatelessWidget {
  const OrderAndDeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: [
          defaultAppBar(title: '주문 · 배송', showActions: false),
          SliverFillRemaining(
              child: Query(
            options: QueryOptions(
              document: gql(OrderQuery.myOrders),
            ),
            builder: (QueryResult<Object?> result,
                {Future<QueryResult<Object?>> Function(FetchMoreOptions)?
                    fetchMore,
                Future<QueryResult<Object?>?> Function()? refetch}) {
              if (result.hasException) {
                return Container();
              }
              if (result.data == null) {
                return Container();
              }

              final endCursor =
                  result.data!['myOrders']['pageInfo']['endCursor'];

              final totalCount = result.data!['myOrders']['totalCount'];

              FetchMoreOptions opts = FetchMoreOptions(
                  variables: {'after': endCursor},
                  updateQuery: (previous, result) {
                    List? previousOrders = List<Map<String, dynamic>>.from(
                        previous!['myOrders']['edges']);
                    List? newOrders = List<Map<String, dynamic>>.from(
                        result!['myOrders']['edges']);

                    final List<Map<String, dynamic>> orders = [
                      ...previousOrders,
                      ...newOrders
                    ];
                    result['myOrders']['edges'] = orders;
                    return result;
                  });

              List? orders = List<Map<String, dynamic>>.from(
                  result.data!['myOrders']['edges'].map((e) => e['node']));
              return NotificationListener<ScrollEndNotification>(
                child: ListView.builder(
                  itemBuilder: (context, index) => index == orders.length
                      ? orders.length < totalCount
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 40.0),
                              child: SpinKitChasingDots(
                                color: Get.theme.primaryColorDark,
                              ),
                            )
                          : const SizedBox(
                              height: 24,
                            )
                      : OrderListItem(
                          order: orders[index],
                          refetch: refetch!,
                        ),
                  itemCount: orders.length + 1,
                ),
                onNotification: (t) {
                  final metrics = t.metrics;
                  if (metrics.atEdge) {
                    bool isTop = metrics.pixels == 0;
                    if (!isTop && orders.length < totalCount) {
                      fetchMore!(opts);
                    }
                  }
                  return true;
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
