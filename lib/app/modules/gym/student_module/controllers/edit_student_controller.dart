import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/utils/extract_number.dart';
import 'package:smarter/app/global/utils/money_formatter.dart';
import 'package:smarter/app/global/utils/phone_formatter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/auth_module/widgets/address_web_view.dart';
import 'package:smarter/app/modules/gym/student_module/quries/classes_and_levels_and_schools.dart';
import 'package:smarter/app/modules/gym/student_module/quries/student_query.dart';

class EditStudentController extends GetxController {
  static EditStudentController get to => Get.find();

  final loadingButtonController = RoundedLoadingButtonController();

  final RxBool isCreating = true.obs;
  late final int id;
  final Rx<String?> selectedClass = Rx<String?>(null);
  final Rx<String?> selectedLevel = Rx<String?>(null);
  final Rx<String?> selectedStatus = Rx<String?>(null);
  final Rx<String?> gender = Rx<String?>(null);
  final Rx<int?> dateToPay = Rx<int?>(null);
  final Rx<DateTime?> birthday = Rx<DateTime?>(null);
  final Rx<DateTime> dateEntered = DateTime.now().obs;
  final Rx<DateTime?> classDateStart = Rx<DateTime?>(null);

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final schoolController = TextEditingController();

  final priceController = TextEditingController();
  final memoController = TextEditingController();
  final memoForHealthController = TextEditingController();
  final memoForPriceController = TextEditingController();

  final parentPhoneController = TextEditingController();
  final parentIdentificationController = TextEditingController();
  final parentDefaultPasswordController = TextEditingController();
  final parentRelationController = TextEditingController();
  final parentNameController = TextEditingController();
  final parentAddressController = TextEditingController();
  final parentDetailAddressController = TextEditingController();
  final parentZipCodeController = TextEditingController();

  final supporterPhoneController = TextEditingController();
  final supporterRelationController = TextEditingController();
  final supporterNameController = TextEditingController();
  int? parentId;
  bool checked = false;

  final days = [for (var i = 1; i < 31; i++) i];

  final List<String> statusOptions = ['수강중', '퇴원', '휴원중'];

  RxList<String> classes = <String>[].obs;
  RxList<String> levels = <String>[].obs;
  RxList<String> schools = <String>[].obs;
  RxList<String> relationships = <String>[].obs;

  save(runMutation) async {
    if (!checked && parentId == null) {
      loadingButtonController.stop();
      return showSnackBar('주보호자 휴대폰 번호를 확인해주세요.');
    }
    if (selectedClass.value == null ||
        selectedLevel.value == null ||
        selectedStatus.value == null ||
        nameController.text.isEmpty ||
        gender.value == null ||
        birthday.value == null ||
        schoolController.text.isEmpty ||
        dateToPay.value == null ||
        priceController.text.isEmpty ||
        parentPhoneController.text.isEmpty ||
        parentNameController.text.isEmpty ||
        parentRelationController.text.isEmpty) {
      loadingButtonController.stop();
      return showSnackBar('필수항목을 모두 입력해주세요.');
    }
    final parent = {
      'id': parentId,
      'phone': phoneFormatter.unmaskText(parentPhoneController.text),
      'name': parentNameController.text,
      'relationshipName': parentRelationController.text,
      'zipCode': parentZipCodeController.text,
      'address': parentAddressController.text,
      'detailAddress': parentDetailAddressController.text,
      'supporterName': supporterNameController.text,
      'supporterRelationship': supporterRelationController.text,
      'supporterPhone':
          phoneFormatter.unmaskText(supporterPhoneController.text),
    };
    final student = {
      'id': id > 0 ? id : null,
      'className': selectedClass.value,
      'levelName': selectedLevel.value,
      'schoolName': schoolController.text,
      'name': nameController.text,
      'birthday':
          '${birthday.value!.year}-${birthday.value!.month.toString().padLeft(2, '0')}-${birthday.value!.day.toString().padLeft(2, '0')}',
      'status': selectedStatus.value,
      'phone': phoneFormatter.unmaskText(phoneController.text),
      'height': heightController.text.isNotEmpty ? heightController.text : null,
      'weight': weightController.text.isNotEmpty ? weightController.text : null,
      'dateEntered':
          '${dateEntered.value.year}-${dateEntered.value.month.toString().padLeft(2, '0')}-${dateEntered.value.day.toString().padLeft(2, '0')}',
      'dayToPay': dateToPay.value,
      'classDateStart':
          '${classDateStart.value!.year}-${classDateStart.value!.month.toString().padLeft(2, '0')}-${classDateStart.value!.day.toString().padLeft(2, '0')}',
      'gender': gender.value,
      'priceToPay': extractNumber(priceController.text),
      'memoForHealth': memoForHealthController.text.isNotEmpty
          ? memoForHealthController.text
          : null,
      'memoForPrice': memoForHealthController.text.isNotEmpty
          ? memoForPriceController.text
          : null,
      'memo': memoController.text.isNotEmpty ? memoController.text : null
    };

    runMutation({'parent': parent, 'student': student});
  }

  getParent() async {
    checked = true;
    if (birthday.value == null) {
      showSnackBar('원생의 생년월일을 입력해주세요.');
      return;
    }
    final phone = phoneFormatter.unmaskText(parentPhoneController.text);
    if (phone.length != 11) {
      showSnackBar('휴대폰번호 11자를 정확히 입력해주세요.');
      return;
    }
    final result = await Client().client.value.query(
          QueryOptions(document: gql('''
      query Parent(\$phone: String){
        parent(phone: \$phone){
          id
          user{
            identification
            name
          }
          relationship{
            name
          }
          address
          detailAddress
          zipCode
          supporterName
          supporterRelationship{
            name
          }
          supporterPhone
        }
      }
    '''), variables: {'phone': phone}),
        );
    Map<String, dynamic>? parent = result.data!['parent'];
    parentDefaultPasswordController.text =
        birthday.value!.month.toString().padLeft(2, '0') +
            birthday.value!.day.toString().padLeft(2, '0');
    if (parent == null) {
      parentIdentificationController.text = phone.substring(3) +
          birthday.value!.month.toString().padLeft(2, '0') +
          birthday.value!.day.toString().padLeft(2, '0');
      parentId = null;
    } else {
      parentIdentificationController.text = parent['user']['identification'];
      parentNameController.text = parent['user']['name'];
      parentRelationController.text = parent['relationship']['name'];
      parentZipCodeController.text = parent['zipCode'];
      parentAddressController.text = parent['address'];
      parentDetailAddressController.text = parent['detailAddress'];
      parentId = int.parse(parent['id']);
      if (parent['supporterName'] != null) {
        supporterNameController.text = parent['supporterName'];
      }
      if (parent['supporterRelationship'] != null) {
        supporterRelationController.text =
            parent['supporterRelationship']['name'];
      }
      if (parent['supporterPhone'] != null) {
        supporterPhoneController.text =
            phoneFormatter.maskText(parent['supporterPhone']);
      }
    }
  }

  @override
  void onInit() async {
    id = int.parse(Get.parameters['id']!);
    super.onInit();
    final result = await Client()
        .client
        .value
        .query(QueryOptions(document: gql(classesAndLevelsAndSchools)));
    classes.assignAll(
        List<String>.from(result.data!['myClasses'].map((c) => c['name'])));
    levels.assignAll(
        List<String>.from(result.data!['myLevels'].map((l) => l['name'])));
    schools.assignAll(
        List<String>.from(result.data!['mySchools'].map((l) => l['name'])));
    relationships.assignAll(
        List<String>.from(result.data!['relationships'].map((l) => l['name'])));
    if (id > 0) {
      isCreating.value = false;
      final result = await Client().client.value.query(
          QueryOptions(document: gql(studentQuery), variables: {'id': id}));
      final student = result.data!['student'];
      parentId = int.parse(student['parent']['id']);
      selectedClass.value = student['classMaster']['name'];
      selectedLevel.value = student['level']['name'];
      selectedStatus.value = student['status'];
      nameController.text = student['name'];
      gender.value = student['gender'];
      birthday.value = DateTime.parse(student['birthday']);
      if (student['phone'] != null) {
        phoneController.text = phoneFormatter.maskText(student['phone']);
      }
      heightController.text =
          student['height'] != null ? student['height'].toString() : '';
      weightController.text =
          student['weight'] != null ? student['weight'].toString() : '';
      schoolController.text = student['school']['name'];
      dateEntered.value = DateTime.parse(student['dateEntered']);
      classDateStart.value =
          DateTime.parse(student['classDateStart'] ?? student['dateEntered']);
      dateToPay.value = student['dayToPay'];
      parentPhoneController.text =
          phoneFormatter.maskText(student['parent']['user']['phone']);
      parentIdentificationController.text =
          student['parent']['user']['identification'];
      parentNameController.text = student['parent']['user']['name'];
      parentRelationController.text = student['parent']['relationship']['name'];
      parentAddressController.text = student['parent']['address'];
      parentDetailAddressController.text = student['parent']['detailAddress'];
      parentZipCodeController.text = student['parent']['zipCode'];
      if (student['parent']['supporterName'] != null) {
        supporterNameController.text = student['parent']['supporterName'];
      }

      if (student['parent']['supporterPhone'] != null) {
        supporterPhoneController.text =
            phoneFormatter.maskText(student['parent']['supporterPhone']);
      }
      if (student['parent']['supporterRelationship'] != null) {
        supporterRelationController.text =
            student['parent']['supporterRelationship']['name'];
      }
      priceController.text =
          moneyFormatter.format(student['priceToPay'].toString());
      memoController.text = student['memo'] ?? '';
      memoForHealthController.text = student['memoForHealth'] ?? '';
      memoForPriceController.text = student['memoForPrice'] ?? '';
    } else {
      classDateStart.value = DateTime.now();
    }
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

  Future<void> showAddressBottomSheet() async {
    final data = await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: false,
        builder: (context) {
          return const AddressWebView();
        });
    final mappedData = json.decode(data);
    parentZipCodeController.text = mappedData['zonecode'];
    parentAddressController.text = mappedData['roadAddress'];
  }
}
