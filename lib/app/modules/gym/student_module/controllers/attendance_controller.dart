import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';

class AttendanceController extends GetxController {
  static AttendanceController get to => Get.find();

  final loadingButtonController = RoundedLoadingButtonController();

  final actionTypes = ['등원', '하원', '결석'];
  final RxList<int> selected = <int>[].obs;
  final RxBool isAlarmEnabled = false.obs;
  final absentReason = TextEditingController();
  String classMasterName = '';
  int? attendanceMasterId;

  final selectedClass = Rx<String?>(null);

  bool isSelected(int id) => selected.contains(id);

  final selectedStudentIds = <int>[].obs;

  bool isSelectedStudent(id) {
    return selectedStudentIds.contains(id);
  }

  addOtherClassAttendance(runMutation) {
    if (selectedStudentIds.isEmpty) {
      loadingButtonController.stop();
      return showSnackBar('추가하실 학생을 선택해주세요.');
    }
    runMutation({
      'studentIds': selectedStudentIds,
      'attendanceMasterId': attendanceMasterId
    });
  }

  changeAttendance(String type, runMutation) {
    if (type == '등원' || type == '하원') {
      Get.defaultDialog(
        title: type,
        titlePadding: const EdgeInsets.only(top: 20),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        titleStyle: Get.textTheme.labelMedium,
        content: DefaultText(
          '선택한 학생들을 \n$type 처리 하시겠습니까?',
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          style: Get.textTheme.labelLarge,
        ),
        cancel: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const DefaultText(
              '아니오',
              style: TextStyle(color: errorColor, fontSize: 16),
            ),
          ),
        ),
        confirm: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextButton(
            onPressed: () async {
              Get.back();
              runMutation({'attendanceIds': selected, 'state': type});
              showSnackBar(
                '선택한 학생들이 \n$type 처리 되었습니다.',
              );
            },
            child: DefaultText(
              '네',
              style: TextStyle(color: Get.theme.primaryColorDark, fontSize: 16),
            ),
          ),
        ),
      );
    } else if (type == '결석') {
      Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultText(
                '결석 사유를 입력해주세요',
                style: Get.textTheme.bodySmall,
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedTextField(
                hintText: '결석사유',
                controller: absentReason,
                minWidth: double.infinity,
                maxHeight: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Get.back(),
                      child: const DefaultText(
                        '취소',
                        style: TextStyle(color: errorColor),
                      )),
                  TextButton(
                      onPressed: () {
                        if (absentReason.text.isEmpty) {
                          return showSnackBar('결석사유를 입력해주세요.');
                        }
                        runMutation({
                          'attendanceIds': selected,
                          'state': type,
                          'absentReason': absentReason.text
                        });
                        Get.back();
                        showSnackBar(
                          '선택한 학생들이 \n$type 처리 되었습니다.',
                        );
                      },
                      child: const DefaultText('확인'))
                ],
              ),
            ],
          ),
        ),
        isScrollControlled: true,
      );
    }
  }
}
