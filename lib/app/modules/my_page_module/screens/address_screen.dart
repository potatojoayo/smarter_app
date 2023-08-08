import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/address_query.dart';
import 'package:smarter/app/routes/routes.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(AddressQuery.myAddresses),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
      builder: (result, {refetch, fetchMore}) {
        if (result.isLoading) {
          return SpinKitChasingDots(
            color: Get.theme.primaryColorDark,
          );
        }
        List<Map<String, dynamic>> addresses =
            List<Map<String, dynamic>>.from(result.data!['myAddresses']);
        return Scaffold(
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Get.toNamed(Routes.editAddress);
                  if (result == 'saved') {
                    refetch!();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.primaryColorDark),
                child: const DefaultText(
                  '배송지 추가',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
          body: CustomScrollView(
            slivers: [
              defaultAppBar(title: '배송지 설정', showActions: false),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 150),
                    child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final address = addresses[index];
                          return GestureDetector(
                            onTap: () async {
                              final result = await Get.toNamed(
                                  Routes.editAddress,
                                  arguments: {'address': address});
                              if (result == 'saved') {
                                refetch!();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: address['default']
                                    ? Get.theme.primaryColorDark
                                    : Colors.grey[100],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        DefaultText(
                                          address['name'],
                                          style: TextStyle(
                                              color: address['default']
                                                  ? Get.theme.colorScheme
                                                      .background
                                                  : textColor,
                                              fontSize: 15),
                                          overflow: TextOverflow.visible,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        address['default']
                                            ? DefaultText(
                                                '기본배송지',
                                                style: TextStyle(
                                                    color: Get
                                                        .theme.colorScheme.background,
                                                    fontSize: 11),
                                                overflow: TextOverflow.visible,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.chevronRight,
                                      color: address['default']
                                          ? Get.theme.colorScheme.background
                                          : textColor,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: addresses.length),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/*

 */
