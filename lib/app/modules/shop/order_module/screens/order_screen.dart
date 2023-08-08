import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/order_controller.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/order_delivery_info.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/order_payment_info.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/ordering_products.dart';
import 'package:smarter/app/modules/shop/payment_module/widgets/pay_agreement.dart';
import 'package:smarter/app/modules/shop/payment_module/widgets/payment_button.dart';
import 'package:smarter/graphql_api.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              defaultAppBar(
                title: '결제',
                showActions: false,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.chevronLeft,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: DefaultScreenPadding(
                    child: Query(
                      options: QueryOptions(
                          document: OrderMasterAndAddressesQuery(
                                  variables: OrderMasterAndAddressesArguments(
                                      orderMasterId:
                                          int.parse(Get.parameters['id']!)))
                              .document,
                          variables: {'orderMasterId': Get.parameters['id']}),
                      builder: (QueryResult<Object?> result,
                          {Future<QueryResult<Object?>> Function(
                                  FetchMoreOptions)?
                              fetchMore,
                          Future<QueryResult<Object?>?> Function()? refetch}) {
                        if (result.isLoading) {
                          return Container();
                        }
                        if (result.hasException) {
                          return Container();
                        }
                        final coupons = List<Map<String, dynamic>>.from(
                                result.data!['myCoupons'])
                            .map((c) => OrderMasterAndAddresses$Query$CouponType
                                .fromJson(c))
                            .toList();
                        final didUseCouponToday =
                            result.data!['didUseCouponToday'];
                        Map<String, dynamic>? orderMaster =
                            result.data!['orderMaster'];
                        if (orderMaster!['details'][0]['state'] != '간편주문' &&
                            orderMaster['details'][0]['state'] != '구매요청') {
                          return Container(
                              margin: const EdgeInsets.only(top: 200),
                              child: const Center(
                                  child: DefaultText('이미 주문한 결제입니다.')));
                        }
                        OrderController.to.order = result.data!['orderMaster'];
                        List<Map<String, dynamic>> addresses =
                            List<Map<String, dynamic>>.from(
                                result.data!['myAddresses']);
                        OrderController.to.selectedAddress.value =
                            addresses.firstWhereOrNull((a) =>
                                a['address'] ==
                                    OrderController.to.order['address'] &&
                                a['detailAddress'] ==
                                    OrderController.to.order['detailAddress']);
                        OrderController.to.selectedAddress.value ??=
                            addresses.first;
                        OrderController.to.priceTotal = orderMaster['details']
                                .fold(0, (a, b) => a + b['priceTotal']) +
                            orderMaster['priceDelivery'];
                        OrderController.to.priceToPay =
                            OrderController.to.priceTotal;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DeliveryAddressInfo(
                              addresses: addresses,
                              address: OrderController.to.selectedAddress,
                              type: 'order',
                              refetch: refetch,
                              selectable: true,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: Colors.grey[500]!),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const DefaultText('배송 요청사항'),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  OutlinedTextField(
                                    hintText: '배송요청사항을 입력해주세요.',
                                    minWidth: double.infinity,
                                    controller: OrderController
                                        .to.deliveryRequestController,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            OrderingProducts(orderMaster: orderMaster),
                            OrderPaymentInfo(
                                orderMaster: orderMaster,
                                coupons: coupons,
                                didUseCouponToday: didUseCouponToday),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              height: 24,
                            ),
                            PayAgreement(controller: OrderController.to),
                            PaymentButton(
                              controller: OrderController.to,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          // floatingActionButton: const KakaoFloatingActionButton(),
        ),
      ),
    );
  }
}
