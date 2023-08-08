import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/is_approved.dart';

class ClassPaymentController extends GetxController {
  static ClassPaymentController get to => Get.find();

  final loadingButtonController = RoundedLoadingButtonController();

  final Rx<String?> selectedClass = Rx<String?>(null);
  final paymentStatuses = ['전체', '납부완료', '미납'];
  final Rx<String?> selectedStatus = Rx<String?>(null);

  final sortType = ['이름순', '이름역순', '날짜순'];
  final Rx<String?> selectedSortType = Rx<String?>(null);

  // final billingDaySortType = ['전체', '3일전', '5일전'];
  // final Rx<String?> selectedBillingDaySortType = Rx<String?>(null);

  final Rx<DateTime?> _deliveryDate = Rx<DateTime?>(null);

  DateTime? get deliveryDate => _deliveryDate.value;

  set deliveryDate(value) => _deliveryDate.value = value;

  final RxList<int> selectedUnapprovedPayments = <int>[].obs;

  final classPaymentMasters = <Map<String, dynamic>>[].obs;

  Function? fetchMorePayment;

  refetch() {
    FetchMoreOptions fetchMoreOptions = FetchMoreOptions(
        updateQuery: (previousData, newData) {
          return newData;
        },
        variables: {
          'isApproved': false,
          'type': '신규',
          'filteringName': selectedSortType.value,
          // 'filteringDays': selectedBillingDaySortType.value == '전체'
          //     ? 3000
          //     : int.parse(selectedBillingDaySortType.value!.substring(0, 1))
        });
    fetchMorePayment!(fetchMoreOptions);
  }

  isSelected(id) {
    return selectedUnapprovedPayments.contains(id);
  }

  bool didAllSelected(List payments) {
    return payments.length == selectedUnapprovedPayments.length;
  }

  Future<void> bottomSheetForBillDelivery(Function() refetch) async {
    await Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                DefaultText('발송 하기', style: Get.theme.textTheme.bodyLarge),
                const SizedBox(height: 20),
                DefaultText(
                  '발송 날짜를 선택해 주세요.',
                  style: Get.theme.textTheme.labelLarge,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    DatePicker.showDateTimePicker(Get.context!,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                      // print('change $date');
                    }, onConfirm: (date) {
                      ClassPaymentController.to.deliveryDate = date;
                    }, currentTime: DateTime.now(), locale: LocaleType.ko);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey[500]!)),
                    child: Center(
                      child: Obx(
                        () => ClassPaymentController.to.deliveryDate != null
                            ? DefaultText(
                                DateFormat('yyyy-MM-dd HH:mm').format(
                                    ClassPaymentController.to.deliveryDate!),
                                style: Get.textTheme.labelLarge,
                              )
                            : DefaultText(
                                '날짜선택',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[600]),
                              ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: Get.back,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: DefaultText(
                            '취소',
                            style: TextStyle(color: errorColor),
                          ),
                        )),
                    IsApprovedMutation(
                      onComplete: refetch,
                      builder: (runMutation, result) {
                        return RoundedLoadingButton(
                          width: 50,
                          color: Colors.white,
                          valueColor: Get.theme.primaryColorDark,
                          elevation: 0,
                          onPressed: () {
                            if (ClassPaymentController.to.deliveryDate ==
                                null) {
                              loadingButtonController.stop();
                              showSnackBar('날짜를 선택해주세요.');
                              return;
                            }
                            runMutation({
                              'classPaymentMasterIds': ClassPaymentController
                                  .to.selectedUnapprovedPayments,
                              'date': ClassPaymentController.to.deliveryDate
                                  ?.toIso8601String()
                            });
                          },
                          controller:
                              ClassPaymentController.to.loadingButtonController,
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: DefaultText('발송',
                                style: TextStyle(
                                    color: primaryColor, fontSize: 17)),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ]),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
