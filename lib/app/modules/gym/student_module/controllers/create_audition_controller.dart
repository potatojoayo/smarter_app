import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/audition_calendar_controller.dart';
import 'package:smarter/app/modules/gym/student_module/widgets/calender_bottom_sheet.dart';

class CreateAuditionController extends GetxController {
  static CreateAuditionController get to => Get.find();

  final loadingButtonController = RoundedLoadingButtonController();

  final Rx<String?> currentLevel = Rx<String?>(null);
  final Rx<String?> nextLevel = Rx<String?>(null);
  final Rx<DateTime?> dateAudition = DateTime.tryParse("").obs;
  final Rx<DateTime?> dateAlarm = DateTime.tryParse("").obs;
  final selectedStudentIds = <int>[].obs;

  final RxList auditionList = [].obs;

  addAudition() {
    if (currentLevel.value == null) {
      return showSnackBar('현재 급수를 선택해주세요.');
    }
    if (nextLevel.value == null) {
      return showSnackBar('승급 급수를 선택해주세요.');
    }
    Map<String, dynamic> data = {
      'currentLevel': currentLevel.value,
      'nextLevel': nextLevel.value,
    };
    auditionList.add(data);
  }

  deleteAudition(int index) {
    auditionList.removeAt(index);
  }

  addAuditionList(List<Map<String, dynamic>> list) {
    var event = AuditionCalendarController.to.selectedDay;
    for (var item in list) {
      if (event.value.day ==
          int.parse(item['dateAudition'].toString().substring(8))) {
        Map<String, dynamic> data = {
          'currentLevel': item['currentLevel']['name'],
          'nextLevel': item['nextLevel']['name'],
        };
        auditionList.add(data);
      }
    }
  }

  showBottomSheet() {
    Get.bottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      backgroundColor: backgroundColor,
      isScrollControlled: true,
      const CalenderBottomSheet(),
    );
  }

  bool isSelected(id) {
    return selectedStudentIds.contains(id);
  }

  bool didAllSelected(List students) {
    return students.length == selectedStudentIds.length;
  }

  create(runMutation) {
    if (auditionList.isEmpty) {
      loadingButtonController.stop();
      return showSnackBar('승급할 급수를 추가해주세요.');
    }
    if (dateAlarm.value == null) {
      loadingButtonController.stop();
      return showSnackBar('예약알림 발송일를 선택해주세요.');
    }

    runMutation({
      'auditionMasterObjects': auditionList,
      'dateAudition':
          '${dateAudition.value?.year}-${dateAudition.value?.month.toString().padLeft(2, '0')}-${dateAudition.value?.day.toString().padLeft(2, '0')}',
      'dateAlarm':
          '${dateAlarm.value?.year}-${dateAlarm.value?.month.toString().padLeft(2, '0')}-${dateAlarm.value?.day.toString().padLeft(2, '0')}'
    });
  }

  void showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
