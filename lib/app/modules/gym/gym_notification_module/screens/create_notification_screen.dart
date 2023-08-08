import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/global/widgets/text_field.dart';
import 'package:smarter/app/modules/gym/gym_class_module/quries/classes.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/controllers/create_notification_controller.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/mutations/create_gym_notification.dart';

class CreateNotificationScreen extends StatelessWidget {
  const CreateNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Classes(
      builder: (classMasters, refetch) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: CreateGymNotification(
            builder: (runMutation, result) {
              return Container(
                color: const Color(0xFFF0F3FE),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    centerTitle: true,
                    titleSpacing: 0,
                    title: DefaultText(
                      '알림장 작성',
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
                  ),
                  body: Container(
                    height: double.infinity,
                    color: const Color(0xFFF0F3FE),
                    child: Container(
                      // color: const Color(0xFFF0F3FE),
                      padding: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      filled: false,
                                    ),
                                    icon: Image.asset(
                                        'assets/icon/arrow_down.png'),
                                    value: CreateNotificationController
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
                                      CreateNotificationController
                                          .to
                                          .selectedClass
                                          .value = value!.toString();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  var now = DateTime.now();
                                  CreateNotificationController.to.showDialog(
                                    context,
                                    CupertinoDatePicker(
                                      onDateTimeChanged: (DateTime newTime) {
                                        CreateNotificationController
                                            .to.selectedDate = newTime;
                                      },
                                      minimumDate: now,
                                      mode: CupertinoDatePickerMode.dateAndTime,
                                    ),
                                  );
                                },
                                child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey[500]!)),
                                    child: Obx(() => DefaultText(
                                          CreateNotificationController
                                                      .to.selectedDate !=
                                                  null
                                              ? DateFormat('yyyy-MM-dd HH:mm')
                                                  .format(
                                                      CreateNotificationController
                                                              .to.selectedDate
                                                          as DateTime)
                                              : '발송시간 예약',
                                          style: Get.textTheme.labelLarge,
                                        ))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  var now = DateTime.now();
                                  CreateNotificationController.to.showDialog(
                                    context,
                                    CupertinoDatePicker(
                                      onDateTimeChanged: (DateTime newTime) {
                                        CreateNotificationController
                                            .to.eventDate = newTime;
                                      },
                                      minimumDate: now,
                                      initialDateTime: now,
                                      mode: CupertinoDatePickerMode.dateAndTime,
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Colors.grey[500]!),
                                  ),
                                  child: Obx(
                                    () => DefaultText(
                                      CreateNotificationController
                                                  .to.eventDate !=
                                              null
                                          ? DateFormat('yyyy-MM-dd HH:mm')
                                              .format(
                                                  CreateNotificationController
                                                      .to.eventDate as DateTime)
                                          : '행사일 설정',
                                      style: Get.textTheme.labelLarge,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                ),
                                child: DefaultTextField(
                                  hint: '제목',
                                  textStyle: Get.textTheme.bodySmall,
                                  maxLines: 3,
                                  minLines: 1,
                                  maxLength: 50,
                                  autofocus: false,
                                  controller: CreateNotificationController
                                      .to.titleController,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: DefaultTextField(
                                  hint: '내용',
                                  maxLines: 30,
                                  minLines: 1,
                                  textStyle: Get.textTheme.labelLarge,
                                  autofocus: false,
                                  controller: CreateNotificationController
                                      .to.contentsController,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(() => SizedBox(
                                    height: CreateNotificationController
                                            .to.images.isNotEmpty
                                        ? 200
                                        : 0,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final image =
                                            CreateNotificationController
                                                .to.images[index];
                                        return Stack(
                                          children: [
                                            Image.file(File(image.path)),
                                            Positioned(
                                              right: 5,
                                              top: 5,
                                              child: GestureDetector(
                                                child: const FaIcon(
                                                  FontAwesomeIcons
                                                      .solidCircleXmark,
                                                  size: 15,
                                                ),
                                                onTap: () =>
                                                    CreateNotificationController
                                                        .to
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
                                      itemCount: CreateNotificationController
                                          .to.images.length,
                                    ),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap:
                                    CreateNotificationController.to.pickImages,
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  CreateNotificationController
                                      .to.overlayLoadingProgress
                                      .start(context);
                                  CreateNotificationController.to
                                      .save(runMutation);
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
                                        '알림장 보내기',
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
