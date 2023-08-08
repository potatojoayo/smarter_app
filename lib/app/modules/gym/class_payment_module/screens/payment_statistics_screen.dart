import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/class_payment_module/quries/payment_per_month_query.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/statistics_controller.dart';

class PaymentStatisticsScreen extends StatelessWidget {
  const PaymentStatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    maxTotal(data) {
      int max = 1;
      for (var d in data) {
        if (max < d['amount']!) {
          max = d['amount']!;
        }
      }
      return max;
    }

    return PaymentPerMonthQuery(
      variables: {'year': DateTime.now().year},
      builder: (List<Map<String, dynamic>> data,
          Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return YearPicker(
                                firstDate: DateTime(2021),
                                lastDate: DateTime.now(),
                                selectedDate: DateTime(
                                    StatisticsController.to.selectedYear.value),
                                onChanged: (value) {
                                  StatisticsController.to.selectedYear.value =
                                      value.year;
                                  StatisticsController.to.reload(fetchMore);
                                  Get.back();
                                });
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(
                          () => DefaultText(
                              '${StatisticsController.to.selectedYear.value}'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 230,
                  width: 320,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final d = data[index];
                      return SizedBox(
                        width: (320 - 8 * (data.length - 1)) / data.length,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DefaultText(
                              formatMoney(d['amount']),
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Get.theme.primaryColorDark),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Container(
                              height:
                                  200 * ((d['amount'] as int) / maxTotal(data)),
                              decoration: BoxDecoration(
                                  color: Get.theme.primaryColorDark,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(3),
                                      topLeft: Radius.circular(3))),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            DefaultText(
                              '${d['month']}월',
                              style: const TextStyle(fontSize: 9),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 8,
                      );
                    },
                    itemCount: data.length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DataTable(columns: [
                  DataColumn(
                    label: DefaultText(
                      '월',
                      style: Get.textTheme.labelMedium,
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: DefaultText(
                      '수납액',
                      style: Get.textTheme.labelMedium,
                    ),
                  ),
                ], rows: [
                  for (var d in data)
                    DataRow(cells: [
                      DataCell(
                        DefaultText(
                          '${d["month"]}',
                          style: Get.textTheme.labelMedium,
                        ),
                      ),
                      DataCell(
                        DefaultText(
                          formatMoney(d["amount"]),
                          style: Get.textTheme.labelMedium,
                        ),
                      ),
                    ])
                ]),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
