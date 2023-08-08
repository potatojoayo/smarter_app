import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/utils/day.dart';
import 'package:smarter/app/global/utils/money_formatter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';

const classMaster = '''
  query ClassMaster(\$id: Int){
    classMaster(id: \$id){
      weekDays
      name
      classDetails{
        id
        day
        hourStart
        minStart
        hourEnd
        minEnd
        isDeleted
      }
    }
  }
''';

class EditClassController extends GetxController {
  static EditClassController get to => Get.find();
  late final int id;
  late final bool isCreating;

  Rx<bool> isCheckedAll = false.obs;
  Rx<bool> isCheckedMon = false.obs;
  Rx<bool> isCheckedTue = false.obs;
  Rx<bool> isCheckedWed = false.obs;
  Rx<bool> isCheckedThu = false.obs;
  Rx<bool> isCheckedFri = false.obs;
  Rx<bool> isCheckedSat = false.obs;
  Rx<bool> isCheckedSun = false.obs;


  int hourStart = -1;
  int minStart = -1;
  int hourEnd = -1;
  int minEnd = -1;

  final loadingButtonController = RoundedLoadingButtonController();

  final classNameController = TextEditingController();
  final priceController = TextEditingController();
  final priceDeductPerAbsentController = TextEditingController();

  final classDetails = <Map<String, dynamic>>[].obs;
  final dayList = [0, 0, 0, 0, 0, 0, 0];
  RxList<Map<String, dynamic>> get filteredDeletedDetails =>
      classDetails.where((c) => c['isDeleted'] == false).toList().obs;
  RxList<Map<String, dynamic>> get filteredUpdatingDetails => classDetails
      .where((c) => c['id'] != null || c['isDeleted'] == false)
      .toList()
      .obs;

  List<Map<String, dynamic>> detailDataList = [];
  List<int> weekDaysData = [];

  dynamic classMasterData = {};
  dynamic oriDays = {};

  Rx<String> startTimeText = "".obs;
  Rx<String> endTimeText = "".obs;

  delete(runMutation) {
    Get.back();
    runMutation({
      'classMaster': {
        'id': id,
        'name': classNameController.text,
        'isDeleted': true,
      },
      'weekdays': [],
    });
  }

  save(runMutation, List<String> classMasters) async {

    loadingButtonController.start();
    if (classNameController.text.isEmpty) {
      showSnackBar('클래스명을 입력해주세요.');
      loadingButtonController.stop();
      return;
    }

    // 요일 확인
    if (!isCheckedMon.value &&
        !isCheckedTue.value &&
        !isCheckedWed.value &&
        !isCheckedThu.value &&
        !isCheckedFri.value) {
      showSnackBar('요일을 선택해주세요.');
      loadingButtonController.stop();
      return;
    }

    // 시간 확인
    if (hourStart == -1 || minStart == -1) {
      showSnackBar('수업 시작시간을 입력해주세요.');
      loadingButtonController.stop();
      return;
    }

    if (hourEnd == -1 || minEnd == -1) {
      showSnackBar('수업 종료시간을 입력해주세요.');
      loadingButtonController.stop();
      return;
    }

    if (hourStart * 60 + minStart >= hourEnd * 60 + minEnd) {
      showSnackBar('종료시간이 시작시간보다 빠릅니다.\n\n수업 시간을 바르게 입력해주세요.');
      loadingButtonController.stop();
      return;
    }

    makeDetailDatas();
    await runMutation({
      'classMaster': {
        'id': id > 0 ? id : null,
        'name': classNameController.text,
      },
      'weekdays': weekDaysData,
      'classDetails': {
        'hourStart': hourStart,
        'minStart': minStart,
        'hourEnd': hourEnd,
        'minEnd': minEnd
      }
    });
  }

  @override
  void onInit() async {
    id = int.parse(Get.parameters['id']!);
    if (id > 0) {
      isCreating = false;
      final result = await Client().client.value.query(QueryOptions(
          document: gql(
            classMaster,
          ),
          variables: {'id': id}));
      if (result.data != null) {
        classMasterData = result.data!['classMaster'];
        classNameController.text = classMasterData['name'];
        priceController.text =
            moneyFormatter.format(classMasterData['price'].toString());
        priceDeductPerAbsentController.text = moneyFormatter
            .format(classMasterData['priceDeductPerAbsent'].toString());
        classDetails.assignAll(
          List<Map<String, dynamic>>.from(
            classMasterData['classDetails'].map(
              (detail) => {
                'hourStart': detail['hourStart'],
                'minStart': detail['minStart'],
                'hourEnd': detail['hourEnd'],
                'minEnd': detail['minEnd'],
                'isDeleted': detail['isDeleted'],
                'dayInput': getDay(detail['day']),
                'id': detail['id']
              },
            ),
          ),
        );
        oriDays = classMasterData['weekDays'];
        for (var day in classMasterData['weekDays']) {
          checkDays(day);
        }

        if (classDetails.isNotEmpty) {
          hourStart = classDetails[0]['hourStart'];
          minStart = classDetails[0]['minStart'];
          hourEnd = classDetails[0]['hourEnd'];
          minEnd = classDetails[0]['minEnd'];
        }
      }
    } else {
      isCreating = true;
    }
    getStartTimeText();
    getEndTimeText();
    super.onInit();
  }

  void checkDays(int day) {
    switch (day) {
      case 0:
        isCheckedMon.value = !isCheckedMon.value;
        break;
      case 1:
        isCheckedTue.value = !isCheckedTue.value;
        break;
      case 2:
        isCheckedWed.value = !isCheckedWed.value;
        break;
      case 3:
        isCheckedThu.value = !isCheckedThu.value;
        break;
      case 4:
        isCheckedFri.value = !isCheckedFri.value;
        break;
      case 5:
        isCheckedSat.value = !isCheckedSat.value;
        break;
      case 6:
        isCheckedSun.value = !isCheckedSun.value;
        break;
      case 10:
        isCheckedAll.value = !isCheckedAll.value;
        break;
      default:
        break;
    }
    if (isCheckedMon.value &&
        isCheckedTue.value &&
        isCheckedWed.value &&
        isCheckedThu.value &&
        isCheckedFri.value) {
      isCheckedAll.value = true;
    } else {
      isCheckedAll.value = false;
    }
  }

  void checkAll() {
    isCheckedAll.value = !isCheckedAll.value;
    isCheckedMon.value = isCheckedAll.value;
    isCheckedTue.value = isCheckedAll.value;
    isCheckedWed.value = isCheckedAll.value;
    isCheckedThu.value = isCheckedAll.value;
    isCheckedFri.value = isCheckedAll.value;
  }

  void setStartTime(int hour, int min) {
    hourStart = hour;
    minStart = min;
    getStartTimeText();
  }

  String getStartTimeText() {
    if (hourStart != -1 && minStart != -1) {
      startTimeText.value = '$hourStart:${minStart.toString().padLeft(2, '0')}';
    } else {
      startTimeText.value = '시작시간';
    }
    return startTimeText.value;
  }

  void setEndTime(int hour, int min) {
    hourEnd = hour;
    minEnd = min;
    getEndTimeText();
  }

  String getEndTimeText() {
    if (hourEnd != -1 && minEnd != -1) {
      endTimeText.value = '$hourEnd:${minEnd.toString().padLeft(2, '0')}';
    } else {
      endTimeText.value = '종료시간';
    }
    return endTimeText.value;
  }

  void makeDetailData(int day) {
    var data = {
      'day': day,
      'hourStart': hourStart,
      'minStart': minStart,
      'hourEnd': hourEnd,
      'minEnd': minEnd
    };
    detailDataList.add(data);
    weekDaysData.add(day);
  }

  void makeDetailDatas() {
    detailDataList.clear();
    weekDaysData.clear();
    if (isCheckedMon.value || isCheckedAll.value) {
      makeDetailData(0);
    }
    if (isCheckedTue.value || isCheckedAll.value) {
      makeDetailData(1);
    }
    if (isCheckedWed.value || isCheckedAll.value) {
      makeDetailData(2);
    }
    if (isCheckedThu.value || isCheckedAll.value) {
      makeDetailData(3);
    }
    if (isCheckedFri.value || isCheckedAll.value) {
      makeDetailData(4);
    }
  }
}
