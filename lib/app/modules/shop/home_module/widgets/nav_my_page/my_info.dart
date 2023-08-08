import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/routes/routes.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({
    super.key,
    required this.user,
    this.refetch,
  });

  final Map<String, dynamic> user;
  final Future<QueryResult<Object?>?> Function()? refetch;

  @override
  Widget build(BuildContext context) {
    return DefaultScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2, 2),
                    blurRadius: 16),
              ],
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await Get.toNamed(Routes.editMyInfo);
                    refetch!();
                  },
                  child: Center(
                    child:

                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(2, 2),
                              blurRadius: 4),
                        ],
                      ),
                      width: 80,
                      height: 80,
                      child: Center(
                        child:
                        user['profileImage'] != null
                            ? CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                              user['profileImage']),
                        )
                            : FaIcon(
                          FontAwesomeIcons.user,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.editMyInfo);
                  },
                  child: DefaultText(
                    user['gym']['name'],
                    style: Get.textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.smarterMoney),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            '스마터머니',
                            style: Get.textTheme.labelLarge,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DefaultText(
                                formatMoney(
                                  user['gym']['smarterMoney'],
                                ),
                                style: TextStyle(
                                    color: Get.theme.primaryColorDark,
                                    fontSize: 24),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidChevronRight,
                                color: Get.theme.primaryColorDark,
                                size: 20,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.myCoupons),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            '쿠폰',
                            style: Get.textTheme.labelLarge,
                          ),
                          Row(
                            children: [
                              DefaultText(
                                '${user['coupons'].length} 장',
                                style: const TextStyle(
                                    color: Colors.orange, fontSize: 24),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const FaIcon(
                                FontAwesomeIcons.solidChevronRight,
                                size: 20,
                                color: Colors.orange,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
