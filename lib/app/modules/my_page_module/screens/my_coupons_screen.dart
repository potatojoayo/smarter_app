import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/coupon_item.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/graphql_api.dart';

class MyCouponsScreen extends StatelessWidget {
  const MyCouponsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DefaultText(
          '보유 쿠폰',
          style: Get.textTheme.bodySmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SingleChildScrollView(
          child: Query(
            options: QueryOptions(
              document: MyCouponsQuery().document,
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

              final coupons =
                  List<Map<String, dynamic>>.from(result.data!['myCoupons'])
                      .map((c) =>
                          OrderMasterAndAddresses$Query$CouponType.fromJson(c))
                      .toList();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      CouponItem(coupon: coupons[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemCount: coupons.length,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
