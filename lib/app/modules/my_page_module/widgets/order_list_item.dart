import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/widgets/cancel_order_button.dart';
import 'package:smarter/app/modules/my_page_module/widgets/ordered_product.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrderListItem extends StatelessWidget {
  const OrderListItem({
    Key? key,
    required this.order,
    required this.refetch,
  }) : super(key: key);

  final Map<String, dynamic> order;
  final Future<QueryResult<Object?>?> Function() refetch;

  @override
  Widget build(BuildContext context) {
    final loadingController = RoundedLoadingButtonController();

    return Container(
      margin: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(3, 3), blurRadius: 3)
          ]),
      child: Column(
        children: [
          DefaultScreenPadding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultText(
                  timeago.format(DateTime.parse(order['dateCreated']),
                      locale: 'ko'),
                  style: Get.textTheme.labelLarge,
                ),
                TextButton(
                  onPressed: () async {
                    await Get.toNamed('${Routes.orderDetail}/${order['id']}');
                    refetch();
                  },
                  child: DefaultText(
                    '주문 상세보기  >',
                    style: TextStyle(
                      color: Get.theme.primaryColorDark,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 0,
            thickness: 2,
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              height: 30,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => OrderedProduct(
              orderDetail: order['details'][index],
              orderId: order['id'],
              refetch: refetch,
            ),
            itemCount: order['details'].length,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (order['orderState'] == '결제전' || order['orderState'] == '결제완료')
                CancelOrderButton(
                    loadingController: loadingController,
                    order: order,
                    refetch: refetch),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
