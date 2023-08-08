import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/utils/money_formatter.dart';
import 'package:smarter/app/global/utils/phone_formatter.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/edit_student_controller.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/create_student.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/delete_student.dart';

class EditStudentScreen extends StatelessWidget {
  const EditStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 0,
            title: Obx(
              () => DefaultText(
                EditStudentController.to.isCreating.value ? '원생추가' : '원생정보',
                style: Get.textTheme.bodySmall,
              ),
            ),
            actions: [
              DeleteStudentMutation(
                builder: (runMutation, result) => Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Center(
                    child: GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                            title: '삭제',
                            titleStyle: TextStyle(
                                color: Get.theme.colorScheme.error,
                                fontSize: 15),
                            titlePadding: const EdgeInsets.only(top: 15),
                            content: DefaultText(
                              '정말 원생을 삭제하시겠습니까?',
                              style: Get.textTheme.labelLarge,
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            confirm: RoundedLoadingButton(
                              width: 45,
                              color: Colors.white,
                              valueColor: Get.theme.colorScheme.error,
                              elevation: 0,
                              onPressed: () {
                                Get.back();
                                runMutation(
                                    {'studentId': EditStudentController.to.id});
                              },
                              controller: EditStudentController
                                  .to.loadingButtonController,
                              child: DefaultText(
                                '네',
                                style: TextStyle(
                                    color: Get.theme.colorScheme.error,
                                    fontSize: 18),
                              ),
                            ),
                            cancel: TextButton(
                              onPressed: () => Get.back(),
                              child: DefaultText(
                                '아니오',
                                style: TextStyle(
                                    color: Get.theme.primaryColorDark),
                              ),
                            ),
                          );
                        },
                        child: Obx(
                          () => DefaultText(
                            EditStudentController.to.isCreating.value
                                ? ''
                                : '삭제',
                            style: TextStyle(
                                color: Get.theme.colorScheme.error,
                                fontSize: 17),
                          ),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              CreateStudentMutation(
                builder: (runMutation, result) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Center(
                      child: RoundedLoadingButton(
                        width: 50,
                        color: Colors.white,
                        valueColor: Get.theme.primaryColorDark,
                        elevation: 0,
                        controller:
                            EditStudentController.to.loadingButtonController,
                        onPressed: () {
                          EditStudentController.to.save(runMutation);
                        },
                        child: DefaultText(
                          '저장',
                          style: TextStyle(
                              color: Get.theme.primaryColorDark, fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: DefaultScreenPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DefaultText('원생'),
                        const Divider(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Obx(
                              () => DropdownButton2<String>(
                                hint: DefaultText(
                                  '클래스 *',
                                  style: Get.textTheme.labelLarge,
                                ),
                                value: EditStudentController
                                    .to.selectedClass.value,
                                dropdownMaxHeight: 200,
                                dropdownElevation: 0,
                                dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[200]),
                                items: EditStudentController.to.classes
                                    .map((cls) => DropdownMenuItem<String>(
                                          value: cls,
                                          child: DefaultText(
                                            cls,
                                            style: Get.textTheme.labelLarge,
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  EditStudentController.to.selectedClass.value =
                                      value!;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Obx(() => DropdownButton2<String>(
                                  hint: DefaultText(
                                    '급수 *',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  value: EditStudentController
                                      .to.selectedLevel.value,
                                  dropdownMaxHeight: 200,
                                  dropdownElevation: 0,
                                  dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[200]),
                                  items: EditStudentController.to.levels
                                      .map((cls) => DropdownMenuItem<String>(
                                            value: cls,
                                            child: DefaultText(
                                              cls,
                                              style: Get.textTheme.labelLarge,
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    EditStudentController
                                        .to.selectedLevel.value = value!;
                                  },
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(() => DropdownButton2<String>(
                                  hint: DefaultText(
                                    '수강상태 *',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  value: EditStudentController
                                      .to.selectedStatus.value,
                                  dropdownMaxHeight: 200,
                                  dropdownElevation: 0,
                                  dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[200]),
                                  items: EditStudentController.to.statusOptions
                                      .map((cls) => DropdownMenuItem<String>(
                                            value: cls,
                                            child: DefaultText(
                                              cls,
                                              style: Get.textTheme.labelLarge,
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    EditStudentController
                                        .to.selectedStatus.value = value!;
                                  },
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '이름 *',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                OutlinedTextField(
                                  minWidth: 100,
                                  controller:
                                      EditStudentController.to.nameController,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '성별 *',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Obx(
                                      () => GestureDetector(
                                        onTap: () {
                                          if (EditStudentController
                                                  .to.gender.value !=
                                              '남') {
                                            EditStudentController
                                                .to.gender.value = '남';
                                          } else {
                                            EditStudentController
                                                .to.gender.value = null;
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: EditStudentController
                                                          .to.gender.value ==
                                                      '남'
                                                  ? Get.theme.primaryColorDark
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: EditStudentController
                                                              .to
                                                              .gender
                                                              .value ==
                                                          '남'
                                                      ? Get.theme
                                                          .primaryColorDark
                                                      : Colors.grey[500]!)),
                                          child: Center(
                                              child: DefaultText(
                                            '남',
                                            style: EditStudentController
                                                        .to.gender.value ==
                                                    '남'
                                                ? TextStyle(
                                                    fontSize: 15,
                                                    color: Get.theme.colorScheme
                                                        .background)
                                                : const TextStyle(fontSize: 15),
                                          )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Obx(
                                      () => GestureDetector(
                                        onTap: () {
                                          if (EditStudentController
                                                  .to.gender.value !=
                                              '여') {
                                            EditStudentController
                                                .to.gender.value = '여';
                                          } else {
                                            EditStudentController
                                                .to.gender.value = null;
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: EditStudentController
                                                          .to.gender.value ==
                                                      '여'
                                                  ? Get.theme.primaryColorDark
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: EditStudentController
                                                              .to
                                                              .gender
                                                              .value ==
                                                          '여'
                                                      ? Get.theme
                                                          .primaryColorDark
                                                      : Colors.grey[500]!)),
                                          child: Center(
                                              child: DefaultText(
                                            '여',
                                            style: EditStudentController
                                                        .to.gender.value ==
                                                    '여'
                                                ? TextStyle(
                                                    fontSize: 15,
                                                    color: Get.theme.colorScheme
                                                        .background)
                                                : const TextStyle(fontSize: 15),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '생년월일 *',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    EditStudentController.to.showDialog(
                                      context,
                                      CupertinoDatePicker(
                                        onDateTimeChanged: (DateTime newTime) {
                                          EditStudentController
                                              .to.birthday.value = newTime;
                                        },
                                        initialDateTime: DateTime(2000),
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey[500]!)),
                                    child: Center(
                                      child: Obx(
                                        () => EditStudentController
                                                    .to.birthday.value !=
                                                null
                                            ? DefaultText(
                                                DateFormat('yyyy-MM-dd').format(
                                                    EditStudentController
                                                        .to.birthday.value!),
                                                style: Get.textTheme.labelLarge,
                                              )
                                            : DefaultText(
                                                '날짜선택',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[600]),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '휴대폰 번호',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                OutlinedTextField(
                                  controller:
                                      EditStudentController.to.phoneController,
                                  minWidth: 140,
                                  formatter: phoneFormatter,
                                  maxLength: 17,
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '키',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                OutlinedTextField(
                                  controller:
                                      EditStudentController.to.heightController,
                                  minWidth: 100,
                                  maxLength: 3,
                                  suffix: const DefaultText('cm'),
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '몸무게',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                OutlinedTextField(
                                  controller:
                                      EditStudentController.to.weightController,
                                  minWidth: 100,
                                  maxLength: 3,
                                  suffix: const DefaultText('kg'),
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultText(
                          '학교명 *',
                          style: Get.textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TypeAheadField<String>(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller:
                                  EditStudentController.to.schoolController,
                              style: Get.textTheme.labelLarge,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                            animationStart: 1,
                            noItemsFoundBuilder: (context) =>
                                const SizedBox.shrink(),
                            suggestionsCallback: (pattern) {
                              if (pattern.isNotEmpty) {
                                return EditStudentController.to.schools.where(
                                    (String school) =>
                                        school.contains(pattern));
                              }
                              return [];
                            },
                            itemBuilder: (context, String suggestion) {
                              return ListTile(
                                  title: DefaultText(
                                suggestion,
                                style: Get.textTheme.labelLarge,
                              ));
                            },
                            onSuggestionSelected: (suggestion) {
                              EditStudentController.to.schoolController.text =
                                  suggestion;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                DefaultText(
                                  '수강등록일 *',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    EditStudentController.to.showDialog(
                                      context,
                                      CupertinoDatePicker(
                                        onDateTimeChanged: (DateTime newTime) {
                                          EditStudentController
                                              .to.dateEntered.value = newTime;
                                        },
                                        initialDateTime: DateTime.now(),
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey[500]!)),
                                    child: Obx(() => DefaultText(
                                          DateFormat('yyyy-MM-dd').format(
                                              EditStudentController
                                                  .to.dateEntered.value),
                                          style: Get.textTheme.labelLarge,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                DefaultText(
                                  '수업시작일 *',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    EditStudentController.to.showDialog(
                                      context,
                                      CupertinoDatePicker(
                                        onDateTimeChanged: (DateTime newTime) {
                                          EditStudentController.to
                                              .classDateStart.value = newTime;
                                        },
                                        initialDateTime: DateTime.now(),
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey[500]!)),
                                    child: Obx(() => DefaultText(
                                          EditStudentController.to
                                                      .classDateStart.value !=
                                                  null
                                              ? DateFormat('yyyy-MM-dd').format(
                                                  EditStudentController
                                                      .to.classDateStart.value!)
                                              : DateFormat('yyyy-MM-dd')
                                                  .format(DateTime.now()),
                                          style: Get.textTheme.labelLarge,
                                        )),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultText(
                          '원비 납입일 *',
                          style: Get.textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            DefaultText(
                              '매달',
                              style: Get.textTheme.bodySmall,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Obx(
                              () => EditStudentController.to.isCreating.value
                                  ? Obx(
                                      () => DropdownButton2<int>(
                                        dropdownMaxHeight: 200,
                                        value: EditStudentController
                                            .to.dateToPay.value,
                                        dropdownElevation: 0,
                                        dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[200]),
                                        items: EditStudentController.to.days
                                            .map((cls) => DropdownMenuItem<int>(
                                                  value: cls,
                                                  child: DefaultText(
                                                    cls.toString(),
                                                    style: Get
                                                        .textTheme.labelLarge,
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          EditStudentController
                                              .to.dateToPay.value = value!;
                                        },
                                      ),
                                    )
                                  : DefaultText(
                                      EditStudentController.to.dateToPay.value
                                          .toString(),
                                    ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            DefaultText(
                              '일',
                              style: Get.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultText(
                          '원비 *',
                          style: Get.textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        OutlinedTextField(
                          controller: EditStudentController.to.priceController,
                          maxHeight: 50,
                          minWidth: 200,
                          keyboardType: TextInputType.number,
                          formatter: moneyFormatter,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultText(
                          '메모',
                          style: Get.textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                            style: Get.textTheme.labelLarge,
                            controller: EditStudentController.to.memoController,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            maxLines: 2),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultText(
                          '건강 메모',
                          style: Get.textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                            style: Get.textTheme.labelLarge,
                            controller: EditStudentController
                                .to.memoForHealthController,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            maxLines: 2),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultText(
                          '원비 메모',
                          style: Get.textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                            style: Get.textTheme.labelLarge,
                            controller:
                                EditStudentController.to.memoForPriceController,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            maxLines: 2),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DefaultText('주보호자'),
                        const Divider(
                          height: 20,
                        ),
                        DefaultText(
                          '휴대폰 번호 *',
                          style: Get.textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            OutlinedTextField(
                              controller: EditStudentController
                                  .to.parentPhoneController,
                              minWidth: 140,
                              formatter: MaskTextInputFormatter(
                                  mask: '### - #### - ####',
                                  filter: {'#': RegExp(r'[0-9]')},
                                  type: MaskAutoCompletionType.lazy),
                              maxLength: 17,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                EditStudentController.to.getParent();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Get.theme.primaryColorDark,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const DefaultText(
                                  '확인',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '아이디',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                OutlinedTextField(
                                  enabled: false,
                                  controller: EditStudentController
                                      .to.parentIdentificationController,
                                  minWidth: 100,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '이름 *',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                OutlinedTextField(
                                  controller: EditStudentController
                                      .to.parentNameController,
                                  minWidth: 100,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '관계 *',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: TypeAheadField<String>(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        controller: EditStudentController
                                            .to.parentRelationController,
                                        style: Get.textTheme.labelLarge,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                        ),
                                      ),
                                      animationStart: 1,
                                      noItemsFoundBuilder: (context) =>
                                          const SizedBox.shrink(),
                                      suggestionsCallback: (pattern) {
                                        if (pattern.isNotEmpty) {
                                          return EditStudentController
                                              .to.relationships
                                              .where((String relationship) =>
                                                  relationship
                                                      .contains(pattern));
                                        }
                                        return [];
                                      },
                                      itemBuilder:
                                          (context, String suggestion) {
                                        return ListTile(
                                            title: DefaultText(
                                          suggestion,
                                          style: Get.textTheme.labelLarge,
                                        ));
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        EditStudentController
                                            .to
                                            .parentRelationController
                                            .text = suggestion;
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultText(
                          '우편번호',
                          style: Get.textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            OutlinedTextField(
                              enabled: false,
                              controller: EditStudentController
                                  .to.parentZipCodeController,
                              minWidth: 100,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                EditStudentController.to
                                    .showAddressBottomSheet();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Get.theme.primaryColorDark,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const DefaultText(
                                  '주소찾기',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultText(
                          '주소',
                          style: Get.textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        OutlinedTextField(
                          enabled: false,
                          controller:
                              EditStudentController.to.parentAddressController,
                          minWidth: double.infinity,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultText(
                          '상세주소',
                          style: Get.textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        OutlinedTextField(
                          controller: EditStudentController
                              .to.parentDetailAddressController,
                          minWidth: double.infinity,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const DefaultText('부보호자'),
                        const Divider(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '이름',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                OutlinedTextField(
                                  controller: EditStudentController
                                      .to.supporterNameController,
                                  minWidth: 100,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  '관계',
                                  style: Get.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: TypeAheadField<String>(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        controller: EditStudentController
                                            .to.supporterRelationController,
                                        style: Get.textTheme.labelLarge,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                        ),
                                      ),
                                      animationStart: 1,
                                      noItemsFoundBuilder: (context) =>
                                          const SizedBox.shrink(),
                                      suggestionsCallback: (pattern) {
                                        if (pattern.isNotEmpty) {
                                          return EditStudentController
                                              .to.relationships
                                              .where((String relationship) =>
                                                  relationship
                                                      .contains(pattern));
                                        }
                                        return [];
                                      },
                                      itemBuilder:
                                          (context, String suggestion) {
                                        return ListTile(
                                            title: DefaultText(
                                          suggestion,
                                          style: Get.textTheme.labelLarge,
                                        ));
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        EditStudentController
                                            .to
                                            .supporterRelationController
                                            .text = suggestion;
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultText(
                          '휴대폰 번호',
                          style: Get.textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        OutlinedTextField(
                          controller:
                              EditStudentController.to.supporterPhoneController,
                          minWidth: 140,
                          formatter: MaskTextInputFormatter(
                              mask: '### - #### - ####',
                              filter: {'#': RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          maxLength: 17,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
