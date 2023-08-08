import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/utils/day.dart';
import 'package:smarter/app/global/utils/extract_number.dart';
import 'package:smarter/app/global/utils/money_formatter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';

const classMaster = '''
  query ClassMaster(\$id: ID!){
    classMaster(id: \$id){
      name
      classMasterId
      price
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
  late final String id;
  late final bool isCreating;
  int? classMasterId;

  final classNameController = TextEditingController();
  final priceController = TextEditingController();
  final priceDeductPerAbsentController = TextEditingController();

  final classDetails = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> get filteredDeletedDetails =>
      classDetails.where((c) => c['isDeleted'] == false).toList().obs;
  RxList<Map<String, dynamic>> get filteredUpdatingDetails => classDetails
      .where((c) => c['id'] != null || c['isDeleted'] == false)
      .toList()
      .obs;

  delete(runMutation) {
    Get.back();
    runMutation({
      'classMaster': {
        'id': classMasterId,
        'name': classNameController.text,
        'price': extractNumber(priceController.text),
        'priceDeductPerAbsent':
            extractNumber(priceDeductPerAbsentController.text),
        'isDeleted': true,
      },
    });
  }

  save(runMutation) async {
    if (classNameController.text.isEmpty) {
      showSnackBar('클래스명을 입력해주세요.');
      return;
    }
    if (priceController.text.isEmpty) {
      showSnackBar('원비를 입력해주세요.');
      return;
    }
    if (priceDeductPerAbsentController.text.isEmpty) {
      showSnackBar('결석일당 차감액을 입력해주세요.');
      return;
    }
    if (classDetails.isEmpty) {
      showSnackBar('수업시간을 등록해주세요.');
      return;
    }

    for (var detail in classDetails) {
      if (detail['day'] == '요일') {
        showSnackBar('수업 요일을 선택해주세요.');
        return;
      }
      if (detail['hourStart'] == null) {
        showSnackBar('수업 시작시간을 입력해주세요.');
        return;
      }
      if (detail['hourEnd'] == null) {
        showSnackBar('수업 종료시간을 입력해주세요.');
        return;
      }
      detail['day'] = getDayCode(detail['dayInput']);
    }

    runMutation({
      'classMaster': {
        'id': classMasterId,
        'name': classNameController.text,
        'price': extractNumber(priceController.text),
        'priceDeductPerAbsent':
            extractNumber(priceDeductPerAbsentController.text),
      },
      'classDetails': filteredUpdatingDetails
          .map((d) => {
                'id': d['id'],
                'day': d['day'],
                'hourStart': d['hourStart'],
                'minStart': d['minStart'],
                'hourEnd': d['hourEnd'],
                'minEnd': d['minEnd'],
                'isDeleted': d['isDeleted']
              })
          .toList(),
    });
  }

  @override
  void onInit() async {
    id = Get.parameters['id']!;
    if (id != 'new') {
      isCreating = false;
      final result = await Client().client.value.query(QueryOptions(
          document: gql(
            classMaster,
          ),
          variables: {'id': id}));
      if (result.data != null) {
        final classMasterData = result.data!['classMaster'];
        classMasterId = classMasterData['classMasterId'];
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
      }
    } else {
      isCreating = true;
    }
    super.onInit();
  }
}
