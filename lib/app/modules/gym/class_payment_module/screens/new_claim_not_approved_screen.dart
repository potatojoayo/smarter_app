import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/utils/phone_formatter.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/class_payment_module/controllers/class_payment_controller.dart';
import 'package:smarter/app/modules/gym/class_payment_module/quries/my_class_payment_masters.dart';
import 'package:smarter/app/modules/gym/class_payment_module/widgets/fee_sort_dropdown_button.dart';
import 'package:smarter/app/modules/gym/gym_class_module/quries/classes.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class NewClaimNotApprovedScreen extends StatelessWidget {
  const NewClaimNotApprovedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyClassPaymentMastersQuery(
      variables: {
        'isApproved': false,
        'type': '신규',
        'filteringName':
            ClassPaymentController.to.selectedSortType.value != '정렬순서'
                ? ClassPaymentController.to.selectedSortType.value
                : ''
      },
      builder: (List<Map<String, dynamic>> classPaymentMasters, refetch,
          fetchMore, bool hasNextPage, String? endCursor, int totalCount) {
        ClassPaymentController.to.fetchMorePayment = fetchMore;
        ClassPaymentController.to.classPaymentMasters.value =
            classPaymentMasters;
        return Scaffold(
          floatingActionButton: Obx(
            () => GestureDetector(
              onTap: () {
                ClassPaymentController.to.deliveryDate = null;
                ClassPaymentController.to.bottomSheetForBillDelivery(refetch);
              },
              child: ClassPaymentController
                      .to.selectedUnapprovedPayments.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Get.theme.primaryColorDark,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const DefaultText(
                            '발송하기',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          body: Classes(
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
                                    result!['myGymClassPaymentMasters']
                                        ['edges']);
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(1, 1),
                                        spreadRadius: 1)
                                  ]),
                              items: classMasters
                                  .map(
                                    (cls) => DropdownMenuItem<String>(
                                      value: cls['name'],
                                      child: DefaultText(
                                        cls['name'],
                                        style: Get.textTheme.labelLarge,
                                      ),
                                    ),
                                  )
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
                                ClassPaymentController
                                    .to.selectedUnapprovedPayments
                                    .clear();
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
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Checkbox(
                                      value: ClassPaymentController.to
                                          .didAllSelected(classPaymentMasters),
                                      onChanged: (bool? value) {
                                        if (ClassPaymentController.to
                                                .didAllSelected(
                                                    classPaymentMasters) &&
                                            classPaymentMasters.isNotEmpty) {
                                          ClassPaymentController
                                              .to.selectedUnapprovedPayments
                                              .clear();
                                        } else {
                                          ClassPaymentController
                                              .to.selectedUnapprovedPayments
                                              .assignAll(classPaymentMasters
                                                  .map((s) => s[
                                                      'classPaymentMasterId']));
                                        }
                                      },
                                    ),
                                  ),
                                  const Text(
                                    '전체선택',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: FeeSortDropDownButton(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              if (index < classPaymentMasters.length) {
                                final payment = classPaymentMasters[index];
                                return GestureDetector(
                                  onTap: () async {
                                    final id = payment['classPaymentMasterId'];
                                    if (ClassPaymentController.to
                                        .isSelected(id)) {
                                      ClassPaymentController
                                          .to.selectedUnapprovedPayments
                                          .removeWhere((s) => s == id);
                                    } else {
                                      ClassPaymentController
                                          .to.selectedUnapprovedPayments
                                          .add(id);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Stack(
                                      children: [
                                        Material(
                                          elevation: 3,
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 20, 20, 0),
                                            height: 150,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        DefaultText(
                                                            payment['student']
                                                                ['name']),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Get.theme
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: DefaultText(
                                                            payment['classMaster']
                                                                ['name'],
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        DefaultText(
                                                          '수납예정일',
                                                          style: Get.textTheme
                                                              .labelSmall,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        DefaultText(
                                                          DateFormat(
                                                                  'yyyy.MM.dd')
                                                              .format(
                                                            DateTime.parse(
                                                              payment[
                                                                  'dateToPay'],
                                                            ),
                                                          ),
                                                          style: TextStyle(
                                                            color: Get.theme
                                                                .primaryColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        DefaultText(
                                                          DateFormat(
                                                                  'yyyy.MM.dd')
                                                              .format(
                                                            DateTime.parse(
                                                              payment['student']
                                                                  ['birthday'],
                                                            ),
                                                          ),
                                                          style: Get.textTheme
                                                              .labelMedium,
                                                        ),
                                                        DefaultText(
                                                          payment['student']
                                                              ['gender'],
                                                          style: Get.textTheme
                                                              .labelMedium,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Obx(
                                            () => Container(
                                              // height: double.infinity,
                                              // width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: ClassPaymentController.to
                                                        .isSelected(payment[
                                                            'classPaymentMasterId'])
                                                    ? Get.theme.primaryColorDark
                                                        .withOpacity(0.4)
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 90, 15, 0),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Column(
                                              children: [
                                                payment['memo'] != null
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(1),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.5),
                                                              child: DefaultText(
                                                                  payment['memo'] ??
                                                                      '',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black45))),
                                                        ],
                                                      )
                                                    : Container(),
                                                GestureDetector(
                                                  onTap: () async {
                                                    final url = Uri.parse(
                                                        "tel:${payment['student']['parent']['user']['phone']}");
                                                    if (await canLaunchUrl(
                                                        url)) {
                                                      launchUrl(url);
                                                    } else {
                                                      // ignore: avoid_print
                                                      print(
                                                          "Can't launch $url");
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black54),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            const FaIcon(
                                                              FontAwesomeIcons
                                                                  .solidPhone,
                                                              size: 8,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            DefaultText(
                                                              phoneFormatter.maskText(
                                                                  payment['student']['parent']
                                                                              [
                                                                              'user']
                                                                          [
                                                                          'phone'] ??
                                                                      ''),
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          13),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 50, 1, 0),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () async {
                                                await Get.toNamed(
                                                  '${Routes.classPaymentDetail}/${payment['id']}',
                                                );
                                                ClassPaymentController.to
                                                    .refetch();
                                              },
                                              child: Container(
                                                width: 200,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    DefaultText(
                                                      formatMoney(
                                                        payment['priceToPay'],
                                                      ),
                                                      style: TextStyle(
                                                          color: Get.theme
                                                              .primaryColor,
                                                          fontSize: 21,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    DefaultText(
                                                      '원',
                                                      style: TextStyle(
                                                          color: Get.theme
                                                              .primaryColor,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                      child: Image.asset(
                                                          'assets/icon/next_page_button.png'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
