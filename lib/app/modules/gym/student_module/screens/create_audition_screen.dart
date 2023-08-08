import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/utils/get_date_only.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/create_audition_controller.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/create_audition_master.dart';
import 'package:smarter/app/modules/gym/student_module/quries/levels_query.dart';
import 'package:smarter/app/modules/gym/student_module/quries/students_query.dart';

class CreateAuditionScreen extends StatelessWidget {
  const CreateAuditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: DefaultText(
          '승급 생성',
          style: Get.textTheme.bodySmall,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CreateAuditionMaster(builder: (runMutation, result) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // 달력을 띄워서 기존의 승급 기록이 있는 날만 표시
                      // 선택이 되면 선택된 날의 승급 정보를 불러와서 화면에 표시
                      CreateAuditionController.to.showBottomSheet();
                    },
                    child: DefaultText(
                      '불러오기',
                      style: TextStyle(
                          color: Get.theme.primaryColorDark, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  RoundedLoadingButton(
                    width: 50,
                    color: Colors.white,
                    valueColor: Get.theme.primaryColorDark,
                    elevation: 0,
                    controller:
                        CreateAuditionController.to.loadingButtonController,
                    onPressed: () {
                      CreateAuditionController.to.create(runMutation);
                    },
                    child: DefaultText(
                      '저장',
                      style: TextStyle(
                          color: Get.theme.primaryColorDark, fontSize: 20),
                    ),
                  ),
                ],
              );
            }),
          )
        ],
      ),
      body: LevelsQuery(
          builder: (levels) => StudentsQuery(
                  variables: {
                    'level':
                        CreateAuditionController.to.currentLevel.value ?? '_',
                  },
                  builder: (students, _, __, ___, fetchMore, _____) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(() => DropdownButton2<String>(
                                            hint: DefaultText(
                                              '현재급수',
                                              style: Get.textTheme.labelLarge,
                                            ),
                                            value: CreateAuditionController
                                                .to.currentLevel.value,
                                            dropdownMaxHeight: 180,
                                            dropdownElevation: 0,
                                            dropdownDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey[180]),
                                            items: levels
                                                .map((cls) =>
                                                    DropdownMenuItem<String>(
                                                      value: cls,
                                                      child: DefaultText(
                                                        cls,
                                                        style: Get.textTheme
                                                            .labelLarge,
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              CreateAuditionController.to
                                                  .currentLevel.value = value!;
                                              FetchMoreOptions
                                                  fetchMoreOptions =
                                                  FetchMoreOptions(
                                                      updateQuery:
                                                          (previousData,
                                                              newData) {
                                                        return newData;
                                                      },
                                                      variables: {
                                                    'level': value,
                                                  });
                                              fetchMore!(fetchMoreOptions);
                                            },
                                          )),
                                      const FaIcon(
                                        FontAwesomeIcons.arrowRight,
                                        size: 18,
                                      ),
                                      Obx(() => DropdownButton2<String>(
                                            hint: DefaultText(
                                              '승급급수',
                                              style: Get.textTheme.labelLarge,
                                            ),
                                            value: CreateAuditionController
                                                .to.nextLevel.value,
                                            dropdownMaxHeight: 180,
                                            dropdownElevation: 0,
                                            dropdownDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey[180]),
                                            items: levels
                                                .map((cls) =>
                                                    DropdownMenuItem<String>(
                                                      value: cls,
                                                      child: DefaultText(
                                                        cls,
                                                        style: Get.textTheme
                                                            .labelLarge,
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              CreateAuditionController
                                                  .to.nextLevel.value = value!;
                                            },
                                          )),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // List 추가
                                          CreateAuditionController.to
                                              .addAudition();
                                        },
                                        child: DefaultText(
                                          '추가',
                                          style: TextStyle(
                                              color: Get.theme.primaryColorDark,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DefaultText(
                                        '승급심사일',
                                        style: Get.textTheme.labelMedium,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          CreateAuditionController.to
                                              .showDialog(
                                            context,
                                            CupertinoDatePicker(
                                              onDateTimeChanged:
                                                  (DateTime newTime) {
                                                CreateAuditionController
                                                    .to
                                                    .dateAudition
                                                    .value = newTime;
                                              },
                                              initialDateTime: getDateOnly(
                                                  DateTime.now().add(
                                                      const Duration(days: 2))),
                                              minimumDate: getDateOnly(
                                                  DateTime.now().add(
                                                      const Duration(days: 2))),
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.grey[500]!)),
                                          child: Center(
                                            child: Obx(
                                              () => DefaultText(
                                                CreateAuditionController
                                                            .to
                                                            .dateAudition
                                                            .value ==
                                                        null
                                                    ? '-'
                                                    : DateFormat('yyyy-MM-dd')
                                                        .format(
                                                            CreateAuditionController
                                                                .to
                                                                .dateAudition
                                                                .value!),
                                                style: Get.textTheme.labelLarge,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DefaultText(
                                        '승급일알림발송',
                                        style: Get.textTheme.labelMedium,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (CreateAuditionController
                                                  .to.dateAudition.value ==
                                              null) {
                                            showSnackBar('승급심사일을 먼저 선택해 주세요.');
                                            return;
                                          }
                                          CreateAuditionController.to
                                              .showDialog(
                                            context,
                                            CupertinoDatePicker(
                                              onDateTimeChanged:
                                                  (DateTime newTime) {
                                                CreateAuditionController.to
                                                    .dateAlarm.value = newTime;
                                              },
                                              initialDateTime: getDateOnly(
                                                  DateTime.now().add(
                                                      const Duration(days: 1))),
                                              // CreateAuditionController
                                              //     .to.dateAlarm.value,
                                              minimumDate: getDateOnly(
                                                  DateTime.now().add(
                                                      const Duration(days: 1))),
                                              maximumDate: getDateOnly(
                                                  CreateAuditionController
                                                      .to.dateAudition.value!
                                                      .subtract(const Duration(
                                                          days: 1))),
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.grey[500]!)),
                                          child: Center(
                                            child: Obx(
                                              () => DefaultText(
                                                CreateAuditionController.to
                                                            .dateAlarm.value ==
                                                        null
                                                    ? '-'
                                                    : DateFormat('yyyy-MM-dd')
                                                        .format(
                                                            CreateAuditionController
                                                                    .to
                                                                    .dateAlarm
                                                                    .value ??
                                                                DateTime.now()),
                                                style: Get.textTheme.labelLarge,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) {
                                  // 생성된 아이탬에서 해당의 데이터만 삭제
                                  final audition = CreateAuditionController
                                      .to.auditionList[index];
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // DefaultText(
                                        //   audition['dateAudition'],
                                        //   style: Get.textTheme.labelMedium,
                                        // ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                DefaultText(
                                                  '현재급수',
                                                  style:
                                                      Get.textTheme.labelMedium,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                DefaultText(
                                                    audition['currentLevel'])
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 15.0),
                                              child: FaIcon(
                                                FontAwesomeIcons.arrowRight,
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: [
                                                DefaultText(
                                                  '승급급수',
                                                  style:
                                                      Get.textTheme.labelMedium,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                DefaultText(
                                                    audition['nextLevel'])
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  CreateAuditionController.to
                                                      .deleteAudition(index);
                                                },
                                                icon: FaIcon(
                                                  FontAwesomeIcons.solidCircleX,
                                                  color: Colors.grey[600],
                                                  size: 15,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (_, __) => const SizedBox(
                                  height: 10,
                                ),
                                itemCount: CreateAuditionController
                                    .to.auditionList.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }
}
