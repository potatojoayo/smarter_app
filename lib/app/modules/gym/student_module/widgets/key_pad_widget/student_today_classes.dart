import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/gym_class_module/quries/current_classes_query.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_key_pad_controller.dart';
import 'package:smarter/app/modules/gym/student_module/quries/student_today_classes_query.dart';
import 'package:smarter/app/modules/gym/student_module/widgets/key_pad_widget/other_class_only_one.dart';

import 'other_class_multi.dart';

class StudentTodayClasses extends StatelessWidget {
  const StudentTodayClasses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      StudentTodayClassesQuery(
         studentId: AttendanceKeyPadController.to.studentId,
        builder: (List<Map<String, dynamic>> classes, refetch) {
          if (classes.isEmpty) {
            return CurrentClasses(
                builder: (List<Map<String, dynamic>> classMasters) {
              if (classMasters.isEmpty) {
                return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15)),
                    ),
                    child: const Center(child: DefaultText('출석할 수업이 없습니다.')));
              } else if (classMasters.length == 1) {
                return OtherClassOnlyOne(classMasters: classMasters);
              } else {
                return Obx(() => !AttendanceKeyPadController
                        .to.showCurrentClasses
                    ? Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const DefaultText(
                              '타수업에\n등원 하시겠습니까?',
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    AttendanceKeyPadController
                                        .to.showCurrentClasses = true;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Get.theme.primaryColorDark,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: DefaultText(
                                        '네',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Get.theme.colorScheme.error,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: DefaultText(
                                        '아니오',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    : const OtherClassMulti()
                );
              }
            });
          }
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final classMaster = classes[index];
                return GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultText(
                          classMaster['classMaster']['name'],
                          style: Get.textTheme.bodySmall,
                        ),
                        Row(
                          children: [
                            DefaultText(
                              '${classMaster['hourStart']}:${classMaster['minStart'].toString().padLeft(2, '0')}',
                              style: Get.textTheme.labelLarge,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DefaultText(
                              '~',
                              style: Get.textTheme.labelLarge,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DefaultText(
                              '${classMaster['hourEnd']}:${classMaster['minEnd'].toString().padLeft(2, '0')}',
                              style: Get.textTheme.labelLarge,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: classes.length,
            ),
          );
        });
  }
}
