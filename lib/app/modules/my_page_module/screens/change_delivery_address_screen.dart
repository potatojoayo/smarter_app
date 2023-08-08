import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/address_query.dart';
import 'package:smarter/app/modules/my_page_module/controllers/change_controller.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/order_controller.dart';
import 'package:smarter/app/modules/my_page_module/widgets/delivery_address_item.dart';
import 'package:smarter/app/modules/my_page_module/controllers/return_controller.dart';
import 'package:smarter/app/routes/routes.dart';

class ChangeDeliveryAddressScreen extends StatelessWidget {
  const ChangeDeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectable = Get.arguments['selectable'];
    final type = Get.arguments['type'];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          defaultAppBar(
            title: '배송지 수정',
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
                    document: gql(AddressQuery.myAddresses),
                    fetchPolicy: FetchPolicy.networkOnly,
                  ),
                  builder: (QueryResult<Object?> result,
                      {Future<QueryResult<Object?>> Function(FetchMoreOptions)?
                          fetchMore,
                      Future<QueryResult<Object?>?> Function()? refetch}) {
                    if (result.isLoading) {
                      return Container();
                    }
                    final addresses = result.data!['myAddresses'];
                    return Column(
                      children: [
                        ListView.separated(
                          separatorBuilder: (_, __) => const SizedBox(
                            height: 16,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return DeliveryAddressItem(
                              address: addresses[index],
                              editable: true,
                              selectable: selectable,
                              onEdit: (address) async {
                                await Get.toNamed(Routes.editDeliveryAddress,
                                    arguments: {'address': address});
                                refetch!();
                              },
                              onSelect: (address) async {
                                if (type == 'order') {
                                  await OrderController.to
                                      .changeDeliveryAddress(address);
                                } else if (type == 'return') {
                                  ReturnController.to.selectedAddress.value =
                                      address;
                                } else if (type == 'change/pickup') {
                                  ChangeController.to.pickUpAddress.value =
                                      address;
                                } else if (type == 'change/delivery') {
                                  ChangeController.to.deliveryAddress.value =
                                      address;
                                }
                                Get.back();
                              },
                            );
                          },
                          itemCount: addresses.length,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Get.theme.primaryColorDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: DefaultText(
                                '새 배송지 추가',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () async {
                            await Get.toNamed(Routes.editDeliveryAddress);
                            refetch!();
                          },
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
    );
  }
}
