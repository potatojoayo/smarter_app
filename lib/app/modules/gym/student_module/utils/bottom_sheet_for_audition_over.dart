// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/audition_detail_controller.dart';

import '../mutations/audition_master_pass.dart';

Future<void> bottomSheetForAuditionOver(
    Function() refetch, Map<String, dynamic> audition) async {
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
              DefaultText('승급 완료 확인', style: Get.theme.textTheme.bodyLarge),
              const SizedBox(height: 20),
              DefaultText(
                '예약알림발송 날짜를 선택해 주세요\n완료후 수정은 불가 합니다.',
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
                    AuditionDetailController.to.alarmSendDate = date;
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
                      () => AuditionDetailController.to.alarmSendDate != null
                          ? DefaultText(
                              DateFormat('yyyy-MM-dd HH:mm').format(
                                  AuditionDetailController.to.alarmSendDate!),
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
                  AuditionMasterPassMutation(
                    onComplete: refetch,
                    builder: (runMutation, result) {
                      return TextButton(
                        onPressed: () {
                          if (AuditionDetailController.to.alarmSendDate ==
                              null) {
                            showSnackBar("예약 알림 시간을 선택해 주세요");
                            return;
                          }
                          runMutation({
                            'auditionMasterId': audition['auditionMasterId'],
                            'estimatedAlarmDate': AuditionDetailController
                                .to.alarmSendDate
                                ?.toIso8601String()
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: DefaultText('확인'),
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
