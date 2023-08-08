import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/gym_class_module/quries/classes.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/statistics_controller.dart';
import 'package:smarter/app/modules/gym/student_module/quries/student_statistics_query.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    maxTotal(data) {
      int max = 1;
      for (var d in data) {
        if (max < d['totalStudent']!) {
          max = d['totalStudent']!;
        }
        if (max < d['newStudent']) {
          max = d['newStudent']!;
        }
      }
      return max;
    }

    return Classes(
      builder: (classMasters, fetchMore) {
        classMasters.insert(0, {'name': '전체'});
        return StudentStatisticsQuery(
          variables: {
            'classMasterName': StatisticsController.to.selectedClass,
            'year': DateTime.now().year
          },
          builder: (List<Map<String, dynamic>> data,
              Future<QueryResult<Object?>> Function(FetchMoreOptions)?
                  fetchMore) {
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
                                    selectedDate: DateTime(StatisticsController
                                        .to.selectedYear.value),
                                    onChanged: (value) {
                                      StatisticsController
                                          .to.selectedYear.value = value.year;
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
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => DropdownButton2<String>(
                                    hint: DefaultText(
                                      '전체 클래스',
                                      style: Get.textTheme.labelLarge,
                                    ),
                                    value: StatisticsController
                                        .to.selectedClass.value,
                                    dropdownMaxHeight: 180,
                                    dropdownElevation: 0,
                                    dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[180]),
                                    items: classMasters
                                        .map((cls) => DropdownMenuItem<String>(
                                              value: cls['name'],
                                              child: DefaultText(
                                                cls['name'],
                                                style: Get.textTheme.labelLarge,
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      StatisticsController
                                          .to.selectedClass.value = value!;
                                      StatisticsController.to.reload(fetchMore);
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          child: SizedBox(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (int i = 1; i < 4; i++)
                                  DefaultText(
                                    '${maxTotal(data) ~/ i}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                const DefaultText(
                                  '0',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            height: 230,
                            width: 320,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                final d = data[index];
                                return SizedBox(
                                  width: (320 - 8 * (data.length - 1)) /
                                      data.length,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 200 *
                                                ((d['totalStudent'] as int) /
                                                    maxTotal(data)),
                                            decoration: BoxDecoration(
                                                color:
                                                    Get.theme.primaryColorDark,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(3),
                                                        topLeft:
                                                            Radius.circular(
                                                                3))),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: 200 *
                                                  ((d['newStudent'] as int) /
                                                      maxTotal(data)),
                                              decoration: BoxDecoration(
                                                  color: Colors.green[500],
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  3),
                                                          topLeft:
                                                              Radius.circular(
                                                                  3))),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: 200 *
                                                    ((d['outStudent'] as int) /
                                                        maxTotal(data)),
                                                width: (330 -
                                                        8 * (data.length - 1)) /
                                                    (data.length * 2),
                                                decoration: BoxDecoration(
                                                    color: Get.theme.colorScheme
                                                        .error,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    3),
                                                            topLeft:
                                                                Radius.circular(
                                                                    3))),
                                              ),
                                            ),
                                          ),
                                        ],
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
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 8,
                                );
                              },
                              itemCount: data.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Get.theme.primaryColorDark,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DefaultText(
                            '학생수',
                            style: Get.textTheme.labelMedium,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.green[500],
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DefaultText(
                            '신규 학생수',
                            style: Get.textTheme.labelMedium,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Get.theme.colorScheme.error,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DefaultText(
                            '퇴원 학생수',
                            style: Get.textTheme.labelMedium,
                          ),
                        ],
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
                        '학생수',
                        style: Get.textTheme.labelMedium,
                      )),
                      DataColumn(
                          label: DefaultText(
                        '신규',
                        style: Get.textTheme.labelMedium,
                      )),
                      DataColumn(
                          label: DefaultText(
                        '퇴원',
                        style: Get.textTheme.labelMedium,
                      ))
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
                              '${d["totalStudent"]}명',
                              style: Get.textTheme.labelMedium,
                            ),
                          ),
                          DataCell(
                            DefaultText(
                              '${d["newStudent"]}명',
                              style: Get.textTheme.labelMedium,
                            ),
                          ),
                          DataCell(
                            DefaultText(
                              '${d["outStudent"]}명',
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
      },
    );
  }
}
