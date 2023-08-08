import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/class_payment_module/controllers/class_payment_controller.dart';
import 'package:smarter/app/modules/gym/class_payment_module/quries/my_class_payment_masters.dart';
import 'package:smarter/app/modules/gym/gym_class_module/quries/classes.dart';
import 'package:smarter/app/routes/routes.dart';

class ClassPaymentScreen extends StatelessWidget {
  const ClassPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyClassPaymentMastersQuery(
      variables: const {'isApproved': true, 'type': null},
      builder: (List<Map<String, dynamic>> classPaymentMasters, refetch,
          fetchMore, bool hasNextPage, String? endCursor, int totalCount) {
        return Classes(
          builder: (List<Map<String, dynamic>> classMasters, _) {
            return NotificationListener<ScrollEndNotification>(
              onNotification: (t) {
                final metrics = t.metrics;
                if (metrics.atEdge) {
                  bool isTop = metrics.pixels == 0;
                  if (!isTop && hasNextPage) {
                    FetchMoreOptions opts = FetchMoreOptions(
                        variables: {
                          'after': endCursor,
                          'classMaster': ClassPaymentController
                                      .to.selectedClass.value !=
                                  '전체'
                              ? ClassPaymentController.to.selectedClass.value
                              : null,
                          'paymentStatus': ClassPaymentController
                                      .to.selectedStatus.value !=
                                  '전체'
                              ? ClassPaymentController.to.selectedStatus.value
                              : null,
                        },
                        updateQuery: (previous, result) {
                          List? previousPayments =
                              List<Map<String, dynamic>>.from(
                                  previous!['myGymClassPaymentMasters']
                                      ['edges']);
                          List? newAttendances =
                              List<Map<String, dynamic>>.from(
                                  result!['myGymClassPaymentMasters']['edges']);
                          final List<Map<String, dynamic>> payments = [
                            ...previousPayments,
                            ...newAttendances
                          ];
                          result['myGymClassPaymentMasters']['edges'] =
                              payments;
                          return result;
                        });
                    fetchMore!(opts);
                  }
                }
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(
                            () => DropdownButton2<String>(
                              hint: DefaultText(
                                '클래스',
                                style: Get.textTheme.labelLarge,
                              ),
                              value:
                                  ClassPaymentController.to.selectedClass.value,
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
                                  .toList()
                                ..insert(
                                    0,
                                    DropdownMenuItem<String>(
                                      value: '전체',
                                      child: DefaultText(
                                        '전체',
                                        style: Get.textTheme.labelLarge,
                                      ),
                                    )),
                              onChanged: (value) {
                                ClassPaymentController.to.selectedClass.value =
                                    value!;
                                FetchMoreOptions opts = FetchMoreOptions(
                                    variables: {
                                      'classMaster': ClassPaymentController
                                                  .to.selectedClass.value !=
                                              '전체'
                                          ? ClassPaymentController
                                              .to.selectedClass.value
                                          : null,
                                      'paymentStatus': ClassPaymentController
                                                  .to.selectedStatus.value !=
                                              '전체'
                                          ? ClassPaymentController
                                              .to.selectedStatus.value
                                          : null,
                                    },
                                    updateQuery: (_, result) {
                                      return result;
                                    });
                                fetchMore!(opts);
                              },
                            ),
                          ),
                          Obx(
                            () => DropdownButton2<String>(
                              hint: DefaultText(
                                '수납여부',
                                style: Get.textTheme.labelLarge,
                              ),
                              value: ClassPaymentController
                                  .to.selectedStatus.value,
                              dropdownMaxHeight: 180,
                              dropdownElevation: 0,
                              dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[180]),
                              items: ClassPaymentController.to.paymentStatuses
                                  .map((s) => DropdownMenuItem<String>(
                                        value: s,
                                        child: DefaultText(
                                          s,
                                          style: Get.textTheme.labelLarge,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                ClassPaymentController.to.selectedStatus.value =
                                    value!;
                                FetchMoreOptions opts = FetchMoreOptions(
                                    variables: {
                                      'classMaster': ClassPaymentController
                                                  .to.selectedClass.value !=
                                              '전체'
                                          ? ClassPaymentController
                                              .to.selectedClass.value
                                          : null,
                                      'paymentStatus': ClassPaymentController
                                                  .to.selectedStatus.value !=
                                              '전체'
                                          ? ClassPaymentController
                                              .to.selectedStatus.value
                                          : null,
                                    },
                                    updateQuery: (_, result) {
                                      return result;
                                    });
                                fetchMore!(opts);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: const Color(0xFFF0F3FE),
                      padding: const EdgeInsets.all(15),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          if (index < classPaymentMasters.length) {
                            final payment = classPaymentMasters[index];
                            return GestureDetector(
                              onTap: () async {
                                await Get.toNamed(
                                  '${Routes.classPaymentDetail}/${payment['id']}',
                                );
                                ClassPaymentController.to.refetch();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            DefaultText(
                                                payment['student']['name']),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Get.theme.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: DefaultText(
                                                payment['classMaster']['name'],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            DefaultText(
                                              '수납예정일',
                                              style: Get.textTheme.labelSmall,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            DefaultText(
                                              DateFormat('yyyy.MM.dd').format(
                                                DateTime.parse(
                                                  payment['dateToPay'],
                                                ),
                                              ),
                                              style: TextStyle(
                                                color: Get.theme.primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        DefaultText(
                                          payment['paymentStatus'],
                                          style: TextStyle(
                                              color: payment['paymentStatus'] ==
                                                      '납부완료'
                                                  ? Colors.green
                                                  : Get.theme.colorScheme.error,
                                              fontSize: 20),
                                        ),

                                        ////////////////////////////
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     Column(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.start,
                                        //       children: [
                                        //         DefaultText(
                                        //           '수납예정일',
                                        //           style: Get.textTheme.labelSmall,
                                        //         ),
                                        //         const SizedBox(
                                        //           height: 5,
                                        //         ),
                                        //         DefaultText(
                                        //           DateFormat('yyyy.MM.dd').format(
                                        //             DateTime.parse(
                                        //               payment['dateToPay'],
                                        //             ),
                                        //           ),
                                        //           style: Get.textTheme.labelLarge,
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     Column(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.end,
                                        //       children: [
                                        //         Container(
                                        //           padding:
                                        //               const EdgeInsets.all(10),
                                        //           decoration: BoxDecoration(
                                        //             color:
                                        //                 payment['paymentStatus'] ==
                                        //                         '납부완료'
                                        //                     ? Get.theme
                                        //                         .primaryColorDark
                                        //                     : Get
                                        //                         .theme
                                        //                         .colorScheme
                                        //                         .error,
                                        //             borderRadius:
                                        //                 BorderRadius.circular(10),
                                        //           ),
                                        //           child: DefaultText(
                                        //             payment['paymentStatus'],
                                        //             style: const TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontSize: 15),
                                        //           ),
                                        //         ),
                                        //         payment['datePaid'] != null
                                        //             ? Column(
                                        //                 children: [
                                        //                   const SizedBox(
                                        //                     height: 3,
                                        //                   ),
                                        //                   DefaultText(
                                        //                     DateFormat(
                                        //                             'yyyy.MM.dd')
                                        //                         .format(
                                        //                       DateTime.parse(
                                        //                         payment[
                                        //                             'dateToPay'],
                                        //                       ),
                                        //                     ),
                                        //                     style: Get.textTheme
                                        //                         .labelSmall,
                                        //                   ),
                                        //                 ],
                                        //               )
                                        //             : Container(),
                                        //       ],
                                        //     )
                                        //   ],
                                        // ),
                                        //     const SizedBox(
                                        //       height: 5,
                                        //     ),
                                        //     Row(
                                        //       children: [
                                        //         Container(
                                        //           padding:
                                        //               const EdgeInsets.all(8),
                                        //           decoration: BoxDecoration(
                                        //             color: Get
                                        //                 .theme.primaryColorDark,
                                        //             borderRadius:
                                        //                 BorderRadius.circular(5),
                                        //           ),
                                        //           child: DefaultText(
                                        //             payment['classMaster']
                                        //                 ['name'],
                                        //             style: const TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontSize: 13),
                                        //           ),
                                        //         ),
                                        //         const SizedBox(
                                        //           width: 10,
                                        //         ),
                                        //         DefaultText(
                                        //             payment['student']['name']),
                                        //         const SizedBox(
                                        //           width: 10,
                                        //         ),
                                        //         DefaultText(
                                        //           DateFormat('yyyy.MM.dd').format(
                                        //             DateTime.parse(
                                        //               payment['student']
                                        //                   ['birthday'],
                                        //             ),
                                        //           ),
                                        //           style:
                                        //               Get.textTheme.labelMedium,
                                        //         ),
                                        //         const SizedBox(
                                        //           width: 10,
                                        //         ),
                                        //         DefaultText(
                                        //           payment['student']['gender'],
                                        //           style:
                                        //               Get.textTheme.labelMedium,
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     Align(
                                        //       alignment: Alignment.centerRight,
                                        //       child: DefaultText(
                                        //         formatMoney(
                                        //           payment['priceToPay'],
                                        //         ),
                                        //       ),
                                        //     ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            DefaultText(
                                              DateFormat('yyyy.MM.dd').format(
                                                DateTime.parse(
                                                  payment['student']
                                                      ['birthday'],
                                                ),
                                              ),
                                              style: Get.textTheme.labelMedium,
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            DefaultText(
                                              payment['student']['gender'],
                                              style: Get.textTheme.labelMedium,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            DefaultText(
                                              formatMoney(
                                                payment['priceToPay'],
                                              ),
                                              style: TextStyle(
                                                  color: Get.theme.primaryColor,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            DefaultText(
                                              '원',
                                              style: TextStyle(
                                                  color: Get.theme.primaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          if (hasNextPage) {
                            return SpinKitChasingDots(
                              color: Get.theme.primaryColorDark,
                            );
                          }
                          return Container();
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: classPaymentMasters.length + 1,
                      ),
                    )
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
