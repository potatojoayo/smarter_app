import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/easy_order_query.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:timeago/timeago.dart' as timeago;

class EasyOrderScreen extends StatelessWidget {
  const EasyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          defaultAppBar(title: '간편주문 내역', showActions: false),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 20,
              ),
              child: Query(
                options: QueryOptions(
                  document: gql(EasyOrderQuery.myEasyOrders),
                  fetchPolicy: FetchPolicy.cacheAndNetwork,
                ),
                builder: (result, {refetch, fetchMore}) {
                  if (result.hasException) {
                    return Container();
                  }
                  if (result.data == null) {
                    return Container();
                  }
                  List<Map<String, dynamic>> easyOrders =
                      List<Map<String, dynamic>>.from(result
                          .data!['myEasyOrders']['edges']
                          .map((e) => e['node']));
                  String? endCursor =
                      result.data!['myEasyOrders']['pageInfo']['endCursor'];
                  bool hasNextPage =
                      result.data!['myEasyOrders']['pageInfo']['hasNextPage'];

                  FetchMoreOptions opts = FetchMoreOptions(
                      variables: {'after': endCursor},
                      updateQuery: (previous, result) {
                        List? previousOrders = List<Map<String, dynamic>>.from(
                            previous!['myEasyOrders']['edges']);
                        List? newOrders = List<Map<String, dynamic>>.from(
                            result!['myEasyOrders']['edges']);
                        final List<Map<String, dynamic>> orders = [
                          ...previousOrders,
                          ...newOrders
                        ];
                        result['myEasyOrders']['edges'] = orders;
                        return result;
                      });
                  return NotificationListener<ScrollEndNotification>(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index < easyOrders.length) {
                            final easyOrder = easyOrders[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(2, 2),
                                      blurRadius: 8)
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DefaultText(
                                          timeago.format(
                                            DateTime.parse(
                                                easyOrder['dateCreated']),
                                            locale: 'ko',
                                          ),
                                          style: Get.textTheme.labelMedium,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (easyOrder['state'] == '주문완료') {
                                              if (easyOrder['order']['states']
                                                      [0] ==
                                                  '간편주문') {
                                                Get.toNamed(
                                                    '${Routes.order}/${easyOrder["order"]["orderMasterId"]}');
                                              } else {
                                                Get.toNamed(
                                                    '${Routes.orderDetail}/${easyOrder["order"]["id"]}');
                                              }
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              DefaultText(
                                                easyOrder['order'] != null &&
                                                        easyOrder['order']
                                                                ['states'][0] ==
                                                            '간편주문'
                                                    ? '결제하기'
                                                    : easyOrder['state'],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: easyOrder['state'] ==
                                                          '주문요청'
                                                      ? Get.theme.colorScheme
                                                          .error
                                                      : Get.theme
                                                          .primaryColorDark,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              easyOrder['state'] == '주문완료'
                                                  ? FaIcon(
                                                      FontAwesomeIcons
                                                          .chevronRight,
                                                      size: 15,
                                                      color: Get.theme
                                                          .primaryColorDark,
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    DefaultText(
                                      easyOrder['contents'],
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return hasNextPage
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 40.0,
                                    ),
                                    child: SpinKitChasingDots(
                                      color: Get.theme.primaryColorDark,
                                    ),
                                  )
                                : Container();
                          }
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: easyOrders.length + 1),
                    onNotification: (t) {
                      final metrics = t.metrics;
                      if (metrics.atEdge) {
                        bool isTop = metrics.pixels == 0;
                        if (!isTop && hasNextPage) {
                          fetchMore!(opts);
                        }
                      }
                      return true;
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
