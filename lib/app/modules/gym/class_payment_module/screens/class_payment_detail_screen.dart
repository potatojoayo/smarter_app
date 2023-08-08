import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/extract_number.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/utils/format_phone.dart';
import 'package:smarter/app/global/utils/money_formatter.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/class_payment_module/controllers/class_payment_detail_controller.dart';
import 'package:smarter/app/modules/gym/class_payment_module/mutations/check_paid_mutation.dart';
import 'package:smarter/app/modules/gym/class_payment_module/mutations/update_class_payment_master_mutation.dart';
import 'package:smarter/app/modules/gym/class_payment_module/quries/class_payment_master_query.dart';

class ClassPaymentDetailScreen extends StatelessWidget {
  const ClassPaymentDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ClassPaymentMasterQuery(
        id: Get.parameters['id'],
        builder: (Map<String, dynamic> payment) {
          if (!payment['isApproved']) {
            ClassPaymentDetailController.to.priceToPay.text =
                formatMoney(payment['priceToPay']);
            ClassPaymentDetailController.to.memo.text = payment['memo'] ?? '';
          }
          return PaidCheck(
            builder: (MultiSourceResult<dynamic> Function(Map<String, dynamic>,
                        {Object? optimisticResult})
                    runPaidCheckMutation,
                QueryResult<Object?>? result) {
              return UpdateClassPaymentMasterMutation(
                builder: (MultiSourceResult<dynamic> Function(
                            Map<String, dynamic>,
                            {Object? optimisticResult})
                        runMutation,
                    QueryResult<Object?>? result) {
                  return Scaffold(
                    appBar: AppBar(
                      title: DefaultText(
                        '납부 상세',
                        style: Get.textTheme.bodySmall,
                      ),
                      centerTitle: false,
                      titleSpacing: 0,
                      actions: [
                        payment['isApproved']
                            ? Container()
                            : TextButton(
                                onPressed: () {
                                  runMutation({
                                    'id': payment['classPaymentMasterId'],
                                    'price': extractNumber(
                                        ClassPaymentDetailController
                                                    .to.priceToPay.text !=
                                                ""
                                            ? ClassPaymentDetailController
                                                .to.priceToPay.text
                                            : "0"),
                                    'memo': ClassPaymentDetailController
                                        .to.memo.text,
                                  });
                                },
                                child: const DefaultText('저장'))
                      ],
                    ),
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '이름',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  DefaultText(
                                    payment['student']['name'],
                                    style: Get.textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '생일',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  DefaultText(
                                    DateFormat('yyyy.MM.dd').format(
                                        DateTime.parse(
                                            payment['student']['birthday'])),
                                    style: Get.textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '학생 휴대폰',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  DefaultText(
                                    formatPhone(payment['student']['phone']),
                                    style: Get.textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '보호자 이름',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  DefaultText(
                                    payment['student']['parent']['user']
                                        ['name'],
                                    style: Get.textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '보호자 관계',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  DefaultText(
                                    payment['student']['parent']['relationship']
                                        ['name'],
                                    style: Get.textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '보호자 휴대폰',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  DefaultText(
                                    formatPhone(payment['student']['parent']
                                        ['user']['phone']),
                                    style: Get.textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '수강기간',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  Row(
                                    children: [
                                      DefaultText(
                                        DateFormat('yyyy.MM.dd').format(
                                            DateTime.parse(
                                                payment['dateFrom'])),
                                        style: Get.textTheme.labelSmall,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      DefaultText(
                                        '~',
                                        style: Get.textTheme.labelSmall,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      DefaultText(
                                        DateFormat('yyyy.MM.dd').format(
                                            DateTime.parse(payment['dateTo'])),
                                        style: Get.textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '수납예정일',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  DefaultText(
                                    DateFormat('yyyy.MM.dd').format(
                                        DateTime.parse(payment['dateToPay'])),
                                    style: Get.textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '수납일',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  DefaultText(
                                    payment['datePaid'] != null
                                        ? DateFormat('yyyy.MM.dd').format(
                                            DateTime.parse(payment['datePaid']))
                                        : '-',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '수납방법',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      DefaultText(
                                        payment['paymentMethod'],
                                        style: Get.textTheme.labelLarge,
                                      ),
                                      payment['paymentMethod'] == '미납'
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                      title: "입금확인",
                                                      titlePadding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 20,
                                                              horizontal: 30),
                                                      titleStyle: Get.textTheme
                                                          .labelMedium,
                                                      content: DefaultText(
                                                        '입금을 확인하시겠습니까?',
                                                        style: Get.textTheme
                                                            .labelLarge,
                                                      ),
                                                      cancel: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const DefaultText(
                                                            '아니오',
                                                            style: TextStyle(
                                                                color:
                                                                    errorColor,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                      confirm: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20),
                                                        child: TextButton(
                                                          onPressed: () async {
                                                            runPaidCheckMutation({
                                                              'method': '현장결제',
                                                              'id': payment[
                                                                  'classPaymentMasterId']
                                                            });
                                                            Get.back();
                                                          },
                                                          child: DefaultText(
                                                            '네',
                                                            style: TextStyle(
                                                                color: Get.theme
                                                                    .primaryColorDark,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Get.theme
                                                          .primaryColorDark,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const DefaultText(
                                                      '현장납부 확인',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : payment['paymentMethod'] ==
                                                      '무통장입금' &&
                                                  payment['paymentStatus'] ==
                                                      '미납'
                                              ? Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.defaultDialog(
                                                          title: "입금확인",
                                                          titlePadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 20,
                                                                  horizontal:
                                                                      30),
                                                          titleStyle: Get
                                                              .textTheme
                                                              .labelMedium,
                                                          content: DefaultText(
                                                            '입금을 확인하시겠습니까?',
                                                            style: Get.textTheme
                                                                .labelLarge,
                                                          ),
                                                          cancel: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  const DefaultText(
                                                                '아니오',
                                                                style: TextStyle(
                                                                    color:
                                                                        errorColor,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ),
                                                          confirm: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                runPaidCheckMutation({
                                                                  'method':
                                                                      '무통장입금',
                                                                  'id': payment[
                                                                      'classPaymentMasterId']
                                                                });
                                                                Get.back();
                                                                // runMutation({
                                                                //   'method':
                                                                //   '무통장입금',
                                                                //   'id': payment[
                                                                //   'classPaymentMasterId']
                                                                // });Get.back();
                                                              },
                                                              child:
                                                                  DefaultText(
                                                                '네',
                                                                style: TextStyle(
                                                                    color: Get
                                                                        .theme
                                                                        .primaryColorDark,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Get.theme
                                                              .primaryColorDark,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child:
                                                            const DefaultText(
                                                          '입금 확인',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '차감전 원비',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  DefaultText(
                                    formatMoney(payment['price']),
                                    style: Get.textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '차감후 원비',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  payment['isApproved']
                                      ? DefaultText(
                                          formatMoney(payment['priceToPay']),
                                          style: TextStyle(
                                              color:
                                                  Get.theme.colorScheme.error,
                                              fontSize: 18),
                                        )
                                      : OutlinedTextField(
                                          controller:
                                              ClassPaymentDetailController
                                                  .to.priceToPay,
                                          formatter: moneyFormatter,
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '메모',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  payment['isApproved']
                                      ? DefaultText(
                                          payment['memo'] ?? '-',
                                          style: const TextStyle(fontSize: 18),
                                        )
                                      : OutlinedTextField(
                                          minWidth: 200,
                                          controller:
                                              ClassPaymentDetailController
                                                  .to.memo,
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     DefaultText(
                              //       '결석일',
                              //       style: Get.textTheme.labelLarge,
                              //     ),
                              //
                              //     DefaultText(
                              //       "${payment['daysDeduct']} 일",
                              //       style: const TextStyle(
                              //           fontSize: 18),
                              //     )
                              //   ],
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultText(
                                    '납부상태',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  DefaultText(
                                    payment['paymentStatus'],
                                    style: TextStyle(
                                        color: payment['paymentStatus'] == '미납'
                                            ? Get.theme.colorScheme.error
                                            : Get.theme.primaryColorDark,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
