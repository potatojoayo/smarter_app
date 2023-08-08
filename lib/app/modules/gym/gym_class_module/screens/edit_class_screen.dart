import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/gym_class_module/controllers/edit_class_controller.dart';
import 'package:smarter/app/modules/gym/gym_class_module/mutations/create_or_update_class.dart';
import 'package:smarter/app/modules/gym/gym_class_module/quries/classes.dart';

class EditClassScreen extends StatefulWidget {
  const EditClassScreen({Key? key}) : super(key: key);

  @override
  State<EditClassScreen> createState() => _EditClassScreenState();
}

class _EditClassScreenState extends State<EditClassScreen> {
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(myClasses)),
        builder: (QueryResult<Object?> result,
            {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
            Future<QueryResult<Object?>?> Function()? refetch}) {
          if (result.isLoading) {
            return SpinKitChasingDots(
              color: Get.theme.primaryColorDark,
            );
          }
          if (result.hasException) {
            return Container();
          }
          if (result.data == null) {
            return Container();
          }
          final classMasters = List<String>.from(
              result.data!['myClasses'].map((c) => c['name']));

          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              bottomSheet: CreateOrUpdateClass(
                builder: (runMutation, result) {
                  return Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: [
                        int.parse(Get.parameters['id']!) > 0
                            ? Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: '삭제',
                                      titleStyle: TextStyle(
                                          color: Get.theme.colorScheme.error,
                                          fontSize: 15),
                                      titlePadding:
                                          const EdgeInsets.only(top: 15),
                                      content: DefaultText(
                                        '정말 클래스를 삭제하시겠습니까?',
                                        style: Get.textTheme.labelLarge,
                                      ),
                                      contentPadding: const EdgeInsets.all(10),
                                      confirm: RoundedLoadingButton(
                                          controller: EditClassController
                                              .to.loadingButtonController,
                                          onPressed: () => EditClassController
                                              .to
                                              .delete(runMutation),
                                          child: const DefaultText('네')),
                                      cancel: TextButton(
                                        onPressed: () => Get.back(),
                                        child: DefaultText(
                                          '아니오',
                                          style: TextStyle(
                                              color:
                                                  Get.theme.colorScheme.error),
                                        ),
                                      ),
                                    );
                                  },
                                  child: DefaultText(
                                    '삭제',
                                    style: TextStyle(
                                        color: Get.theme.colorScheme.error),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: TextButton(
                                  onPressed: () => Get.back(),
                                  child: DefaultText(
                                    '취소',
                                    style: TextStyle(
                                        color: Get.theme.colorScheme.error),
                                  ),
                                ),
                              ),
                        Expanded(
                          child: RoundedLoadingButton(
                            color: Colors.white,
                            valueColor: Get.theme.primaryColorDark,
                            elevation: 0,
                            onPressed: () => EditClassController.to
                                .save(runMutation, classMasters),
                            controller:
                                EditClassController.to.loadingButtonController,
                            child: DefaultText(
                              EditClassController.to.isCreating
                                  ? '클래스 생성'
                                  : '저장',
                              style: TextStyle(
                                  color: Get.theme.primaryColorDark,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              appBar: AppBar(
                title: DefaultText(
                  EditClassController.to.isCreating ? '클래스 생성' : '클래스 수정',
                  style: Get.textTheme.bodySmall,
                ),
                titleSpacing: 0,
                centerTitle: false,
              ),
              body: SingleChildScrollView(
                child: DefaultScreenPadding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedTextField(
                        controller: EditClassController.to.classNameController,
                        minWidth: 200,
                        maxHeight: 50,
                        label: '클래스명',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultText(
                        '수업요일',
                        style: Get.textTheme.labelLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Theme(
                        data: ThemeData(
                            textTheme: const TextTheme(
                                bodyMedium: TextStyle(fontSize: 10))),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      '월',
                                      style: TextStyle(
                                          fontSize: 15, color: textColor),
                                    ),
                                    Checkbox(
                                        value: EditClassController
                                            .to.isCheckedMon.value,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            EditClassController.to.checkDays(0);
                                          });
                                        }),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      '화',
                                      style: TextStyle(
                                          fontSize: 15, color: textColor),
                                    ),
                                    Checkbox(
                                        value: EditClassController
                                            .to.isCheckedTue.value,
                                        onChanged: (value) {
                                          setState(() {
                                            EditClassController.to.checkDays(1);
                                          });
                                        }),
                                  ],
                                ),
                                Column(children: [
                                  const Text(
                                    '수',
                                    style: TextStyle(
                                        fontSize: 15, color: textColor),
                                  ),
                                  Checkbox(
                                      value: EditClassController
                                          .to.isCheckedWed.value,
                                      onChanged: (value) {
                                        setState(() {
                                          EditClassController.to.checkDays(2);
                                        });
                                      }),
                                ]),
                                Column(children: [
                                  const Text(
                                    '목',
                                    style: TextStyle(
                                        fontSize: 15, color: textColor),
                                  ),
                                  Checkbox(
                                      value: EditClassController
                                          .to.isCheckedThu.value,
                                      onChanged: (value) {
                                        setState(() {
                                          EditClassController.to.checkDays(3);
                                        });
                                      }),
                                ]),
                                Column(children: [
                                  const Text(
                                    '금',
                                    style: TextStyle(
                                        fontSize: 15, color: textColor),
                                  ),
                                  Checkbox(
                                      value: EditClassController
                                          .to.isCheckedFri.value,
                                      onChanged: (value) {
                                        setState(() {
                                          EditClassController.to.checkDays(4);
                                        });
                                      }),
                                ]),
                                Column(children: [
                                  const Text(
                                    '모두',
                                    style: TextStyle(
                                        fontSize: 15, color: textColor),
                                  ),
                                  Checkbox(
                                      value: EditClassController
                                          .to.isCheckedAll.value,
                                      onChanged: (value) {
                                        setState(() {
                                          EditClassController.to.checkAll();
                                        });
                                      }),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultText(
                        '수업시간',
                        style: Get.textTheme.labelLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(15),
                            child: CupertinoButton(
                                // Display a CupertinoTimerPicker with hour/minute mode.
                                onPressed: () => _showDialog(
                                      CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.time,
                                        initialDateTime: DateTime(
                                            2022,
                                            1,
                                            1,
                                            EditClassController.to.hourStart !=
                                                    -1
                                                ? EditClassController
                                                    .to.hourStart
                                                : 18,
                                            EditClassController.to.minStart !=
                                                    -1
                                                ? EditClassController
                                                    .to.minStart
                                                : 0),
                                        onDateTimeChanged: (DateTime value) {
                                          setState(() {
                                            EditClassController.to.setStartTime(
                                                value.hour, value.minute);
                                          });
                                        },
                                      ),
                                    ),
                                child: Obx(() => Text(
                                      EditClassController
                                          .to.startTimeText.value,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ))),
                          ),
                          const DefaultText(
                            '~',
                            style: TextStyle(fontSize: 25),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(15),
                            child: CupertinoButton(
                                // Display a CupertinoTimerPicker with hour/minute mode.
                                onPressed: () => _showDialog(
                                      CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.time,
                                        initialDateTime: DateTime(
                                            2022,
                                            1,
                                            1,
                                            EditClassController.to.hourEnd != -1
                                                ? EditClassController.to.hourEnd
                                                : 18,
                                            EditClassController.to.minEnd != -1
                                                ? EditClassController.to.minEnd
                                                : 0),
                                        onDateTimeChanged: (DateTime value) {
                                          setState(() {
                                            EditClassController.to.setEndTime(
                                                value.hour, value.minute);
                                          });
                                        },
                                      ),
                                    ),
                                child: Obx(() => Text(
                                      EditClassController.to.endTimeText.value,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
