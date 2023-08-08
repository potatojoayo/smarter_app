import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/global/widgets/text_field.dart';
import 'package:smarter/app/modules/gym/gym_class_module/quries/classes.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/controllers/modify_notification_controller.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/mutations/delete_gym_notification.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/mutations/modify_gym_notification.dart';

class ModifyNotificationScreen extends StatelessWidget {
  const ModifyNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Classes(
      builder: (classMasters, refetch) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            color: const Color(0xFFF0F3FE),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                titleSpacing: 0,
                title: DefaultText(
                  '알림장 수정',
                  style: Get.textTheme.bodyLarge,
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () async {
                      Get.back();
                    },
                    child: FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      size: 20,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: '삭제',
                        titleStyle: TextStyle(
                            color: Get.theme.colorScheme.error, fontSize: 15),
                        titlePadding: const EdgeInsets.only(top: 15),
                        content: DefaultText(
                          '정말 알림장을 삭제하시겠습니까?',
                          style: Get.textTheme.labelLarge,
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        confirm: DeleteGymNotification(
                          builder: (MultiSourceResult<dynamic> Function(
                                      Map<String, dynamic>,
                                      {Object? optimisticResult})
                                  runMutation,
                              QueryResult<Object?>? result) {
                            return RoundedLoadingButton(
                                elevation: 0,
                                color: Colors.white,
                                controller: ModifyNotificationController
                                    .to.loadingButtonController,
                                onPressed: () {
                                  ModifyNotificationController.to.delete(
                                      runMutation,
                                      ModifyNotificationController
                                          .to.notification['notificationId']);
                                },
                                child: DefaultText(
                                  '네',
                                  style: TextStyle(
                                      color: Get.theme.primaryColorDark,
                                      fontSize: 18),
                                ));
                          },
                        ),
                        cancel: TextButton(
                          onPressed: () => Get.back(),
                          child: DefaultText(
                            '아니오',
                            style:
                                TextStyle(color: Get.theme.colorScheme.error),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      '삭제',
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              body: Container(
                height: double.infinity,
                color: const Color(0xFFF0F3FE),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonHideUnderline(
                            child: SizedBox(
                              height: 60,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 0),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  filled: false,
                                ),
                                icon: Image.asset('assets/icon/arrow_down.png'),
                                value: ModifyNotificationController
                                    .to.selectedClass.value,
                                items: classMasters
                                    .map(
                                      (cls) => DropdownMenuItem<String>(
                                        value: cls['name'],
                                        child: DefaultText(
                                          cls['name'],
                                          style: Get.textTheme.labelLarge,
                                        ),
                                      ),
                                    )
                                    .toList()
                                  ..insert(
                                    0,
                                    DropdownMenuItem<String>(
                                      value: '전체',
                                      child: DefaultText(
                                        '전체',
                                        style: Get.textTheme.labelLarge,
                                      ),
                                    ),
                                  ),
                                onChanged: (value) {
                                  ModifyNotificationController.to.selectedClass
                                      .value = value!.toString();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    '발송시간',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        var now = DateTime.now();
                                        ModifyNotificationController.to
                                            .showDialog(
                                          context,
                                          CupertinoDatePicker(
                                            onDateTimeChanged:
                                                (DateTime newTime) {
                                              ModifyNotificationController
                                                  .to.selectedDate = newTime;
                                            },
                                            minimumDate: now,
                                            mode: CupertinoDatePickerMode
                                                .dateAndTime,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey[500]!)),
                                        child: Obx(
                                          () => DefaultText(
                                            ModifyNotificationController
                                                        .to.selectedDate !=
                                                    null
                                                ? DateFormat('yyyy-MM-dd HH:mm')
                                                    .format(
                                                        ModifyNotificationController
                                                                .to.selectedDate
                                                                ?.toLocal()
                                                            as DateTime)
                                                : '발송시간',
                                            style: Get.textTheme.labelLarge,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(children: [
                                const Text(
                                  "행 사 일",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      ModifyNotificationController.to
                                          .showDialog(
                                        context,
                                        CupertinoDatePicker(
                                          onDateTimeChanged:
                                              (DateTime newTime) {
                                            ModifyNotificationController
                                                .to.eventDate = newTime;
                                          },
                                          mode: CupertinoDatePickerMode
                                              .dateAndTime,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey[500]!)),
                                      child: Obx(
                                        () => DefaultText(
                                          ModifyNotificationController
                                                      .to.eventDate !=
                                                  null
                                              ? DateFormat('yyyy-MM-dd').format(
                                                  ModifyNotificationController
                                                      .to.eventDate as DateTime)
                                              : '행사일 설정',
                                          style: Get.textTheme.labelLarge,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: DefaultTextField(
                              hint: '제목',
                              maxLength: 50,
                              maxLines: 3,
                              minLines: 1,
                              textStyle: Get.textTheme.bodySmall,
                              autofocus: false,
                              controller: ModifyNotificationController
                                  .to.titleController,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: DefaultTextField(
                              hint: '내용',
                              maxLines: 30,
                              minLines: 1,
                              textStyle: Get.textTheme.labelLarge,
                              autofocus: false,
                              controller: ModifyNotificationController
                                  .to.contentsController,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => SizedBox(
                              height: ModifyNotificationController
                                      .to.images.isNotEmpty
                                  ? 200
                                  : 0,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  final image = ModifyNotificationController
                                      .to.images[index];
                                  return Stack(
                                    children: [
                                      Image.file(File(image.path)),
                                      Positioned(
                                        right: 5,
                                        top: 5,
                                        child: GestureDetector(
                                          child: const FaIcon(
                                            FontAwesomeIcons.solidCircleXmark,
                                            size: 15,
                                          ),
                                          onTap: () =>
                                              ModifyNotificationController.to
                                                  .removeImage(index),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                                itemCount: ModifyNotificationController
                                    .to.images.length,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: ModifyNotificationController.to.pickImages,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Get.theme.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DefaultText(
                                    '이미지 추가',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.solidPlus,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ModifyGymNotification(
                            builder: (MultiSourceResult<dynamic> Function(
                                        Map<String, dynamic>,
                                        {Object? optimisticResult})
                                    runMutation,
                                QueryResult<Object?>? result) {
                              return GestureDetector(
                                onTap: () {
                                  ModifyNotificationController
                                      .to.overlayLoadingProgress
                                      .start(context);
                                  ModifyNotificationController.to.modify(
                                      runMutation,
                                      ModifyNotificationController
                                          .to.notification['notificationId']);
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Get.theme.primaryColor,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/icon/mail.png'),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      DefaultText(
                                        '알림장 수정',
                                        style: TextStyle(
                                          color: Get.theme.primaryColor,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const FaIcon(
                                        FontAwesomeIcons.solidPlus,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
