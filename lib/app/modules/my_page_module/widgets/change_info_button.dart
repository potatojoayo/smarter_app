import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/graphql_api.dart';

class ChangeInfoButton extends StatelessWidget {
  const ChangeInfoButton({super.key, required this.orderDetail});

  final Map<String, dynamic> orderDetail;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Query(
              options: QueryOptions(
                  document: ChangeDetailOfOrderDetailQuery(
                          variables: ChangeDetailOfOrderDetailArguments(
                              orderDetailId: int.parse(orderDetail['id'])))
                      .document,
                  variables: {'orderDetailId': orderDetail['id']}),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return const SizedBox.shrink();
                }
                final changeDetail = result.data!['changeDetailOfOrderDetail'];
                return Container(
                  color: Get.theme.colorScheme.background,
                  child: Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20,
                        top: 30,
                        bottom: 30,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DefaultText('교환요청 상품'),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const DefaultText(
                                    '컬러',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  DefaultText(
                                      changeDetail['changingProduct']['color']),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const DefaultText(
                                    '사이즈',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  DefaultText(
                                      changeDetail['changingProduct']['size']),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        child: DefaultText(
          '교환상품정보',
          style: TextStyle(fontSize: 15, color: Get.theme.primaryColorDark),
        ),
      ),
    );
  }
}
