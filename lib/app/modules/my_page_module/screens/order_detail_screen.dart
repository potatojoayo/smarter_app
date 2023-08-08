import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/widgets/delivery_info.dart';
import 'package:smarter/app/modules/my_page_module/widgets/ordered_product.dart';
import 'package:smarter/app/modules/my_page_module/widgets/payment_info.dart';
import 'package:smarter/app/modules/shop/order_module/order_query.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = Get.parameters['id'];
    String query = '';
    bool isOrderNumber = false;
    if (id == null) {
      return Container();
    }
    if (id[0] == 'O') {
      isOrderNumber = true;
    }
    if (!isOrderNumber) {
      query = OrderQuery.myOrder;
    } else {
      query = OrderQuery.myOrderByOrderNumber;
    }
    bool byPk = false;
    if (!isOrderNumber && int.tryParse(id) != null) {
      query = OrderQuery.myOrderByPk;
      byPk = true;
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          defaultAppBar(title: '주문상세', showActions: false),
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Query(
                options: QueryOptions(
                  variables: {'id': Get.parameters['id']},
                  document: gql(query),
                ),
                builder: (QueryResult<Object?> result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return Container();
                  }
                  Map<String, dynamic> order = {};
                  if (byPk) {
                    order = result.data!['orderMaster'];
                  } else if (isOrderNumber) {
                    order = result.data!['myOrderByOrderNumber'];
                  } else {
                    order = result.data!['myOrder'];
                  }

                  final bankAccount = result.data!['defaultBankAccount'];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultScreenPadding(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '주문날짜',
                                  style: Get.textTheme.labelSmall,
                                ),
                                DefaultText(
                                  DateFormat('yyyy. MM. dd').format(
                                    DateTime.parse(order['dateCreated']),
                                  ),
                                  style: Get.textTheme.labelLarge,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '주문번호',
                                  style: Get.textTheme.labelSmall,
                                ),
                                DefaultText(
                                  order['orderNumber'],
                                  style: Get.textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 50,
                        thickness: 5,
                      ),
                      PaymentInfo(
                        order: order,
                        bankAccount: bankAccount,
                      ),
                      const Divider(
                        height: 50,
                        thickness: 5,
                      ),
                      DeliveryInfo(
                        order: order,
                      ),
                       const Divider(
                        height: 50,
                        thickness: 5,
                      ),
                      const DefaultScreenPadding(child: DefaultText('주문상품')),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => OrderedProduct(
                          orderDetail: order['details'][index],
                          refetch: refetch,
                        ),
                        itemCount: order['details'].length,
                        separatorBuilder: (context, index) => const Divider(
                          height: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
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
