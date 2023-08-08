import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/graphql_api.graphql.dart';

class CancelOrderButton extends StatelessWidget {
  const CancelOrderButton({
    super.key,
    required this.loadingController,
    required this.order,
    required this.refetch,
  });

  final RoundedLoadingButtonController loadingController;
  final Map<String, dynamic> order;
  final Future<QueryResult<Object?>?> Function() refetch;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          title: "주문취소",
          titlePadding: const EdgeInsets.only(top: 20),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          titleStyle: Get.textTheme.labelLarge,
          content: Column(
            children: [
              DefaultText(
                '주문을 취소하시겠습니까?',
                style: Get.textTheme.labelLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: DefaultText(
                        '아니오',
                        style: TextStyle(
                            color: Get.theme.primaryColorDark, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RoundedLoadingButton(
                      width: 40,
                      color: backgroundColor,
                      elevation: 0,
                      valueColor: Get.theme.primaryColorDark,
                      controller: loadingController,
                      onPressed: () async {
                        loadingController.start();
                        final result = await Client().client.value.mutate(
                              MutationOptions(
                                document: CancelOrderMutation(
                                  variables: CancelOrderArguments(
                                    orderMasterId: order['orderMasterId'],
                                  ),
                                ).document,
                                variables: {
                                  "orderMasterId": order['orderMasterId']
                                },
                              ),
                            );

                        if (result.data!['userCancelOrder']['success']) {
                          Get.back();
                          showSnackBar('주문이 취소되었습니다.');
                          refetch();
                        }
                      },
                      child: DefaultText('주문취소',
                          style: GoogleFonts.ibmPlexSansKr(
                            textStyle: const TextStyle(
                                color: errorColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: errorColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const DefaultText(
          '주문취소',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
