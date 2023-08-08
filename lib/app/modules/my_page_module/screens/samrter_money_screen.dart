import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/my_query.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/widgets/pay_history_item.dart';
import 'package:smarter/app/modules/shop/smarter_money_module/smarter_money_query.dart';
import 'package:smarter/app/routes/routes.dart';

class SmarterMoneyScreen extends StatelessWidget {
  const SmarterMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          defaultAppBar(title: '스마터머니', showActions: false),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
                child: MyQuery(
              query: SmarterMoneyQuery.walletAndHistory,
              builder: (result) {
                Map<String, dynamic>? myWallet = result.data!['myWallet'];
                List? histories = result.data!['mySmarterMoneyHistories']
                        ['edges']
                    .map((e) => e['node'])
                    .toList();

                if (myWallet == null || histories == null) {
                  return Container();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            '보유머니',
                            style: Get.textTheme.labelMedium,
                          ),
                          DefaultText(
                            formatMoney(myWallet['balance']),
                            style: Get.textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DefaultScreenPadding(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Get.theme.primaryColorDark),
                          onPressed: () => Get.toNamed(Routes.charge),
                          child: const DefaultText(
                            '충전하기',
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 8,
                      height: 60,
                    ),
                    DefaultScreenPadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            '머니 내역',
                            style: Get.textTheme.bodyMedium,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final history = histories[index];
                              return PayHistoryItem(
                                  historyType: history['transactionType'],
                                  amount: history['amount'],
                                  dateCreated: history['dateCreated'],
                                  description: history['description']);
                            },
                            itemCount: histories.length,
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}

/*

 */
