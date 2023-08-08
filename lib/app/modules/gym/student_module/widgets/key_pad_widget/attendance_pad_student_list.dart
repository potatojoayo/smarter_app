import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_key_pad_controller.dart';

class AttendancePadStudentList extends StatelessWidget {
  const AttendancePadStudentList({Key? key, required this.students})
      : super(key: key);

  final List<Map<String, dynamic>> students;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final student = students[index];
          if (MediaQuery.of(context).size.shortestSide < 600) {
            return Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DefaultText(
                        student['name'],
                        style: Get.textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      DefaultText(
                        student['school']['name'],
                        style: Get.textTheme.labelLarge,
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            '보호자',
                            style: Get.textTheme.labelSmall,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          DefaultText(
                            student['parent']['user']['name'],
                            style: Get.textTheme.labelLarge,
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DefaultText(
                            '본인이 맞습니까?',
                            style: Get.textTheme.labelLarge,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    AttendanceKeyPadController
                                        .to.overlayLoadingProgress
                                        .start(context);
                                    AttendanceKeyPadController.to
                                        .onSelectStudent(
                                            int.parse(student['id']));
                                  },
                                  child: const DefaultText(
                                    "네",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    AttendanceKeyPadController.to.code.value =
                                        "";
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.red),
                                  child: const Text(
                                    "아니오",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              // ),
                            ],
                          ),
                        ]),
                  )
                ],
              ),
            );
          } else {
            //태블릿인 경우
            return Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DefaultText(
                        student['name'],
                        style: const TextStyle(
                            color: textColor,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      DefaultText(
                        student['school']['name'],
                        style: const TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            '보호자',
                            style: Get.textTheme.labelSmall,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          DefaultText(
                            student['parent']['user']['name'],
                            style: Get.textTheme.labelLarge,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DefaultText(
                            '본인이 맞습니까?',
                            style: Get.textTheme.labelLarge,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    AttendanceKeyPadController
                                        .to.overlayLoadingProgress
                                        .start(context);
                                    AttendanceKeyPadController.to
                                        .onSelectStudent(
                                            int.parse(student['id']));
                                  },
                                  child: const DefaultText(
                                    "네",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 35),
                                  )),
                              const SizedBox(
                                width: 40,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    AttendanceKeyPadController.to.code.value =
                                        "";
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.red),
                                  child: const Text(
                                    "아니오",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 35),
                                  )),
                            ],
                          )
                        ]),
                  )
                ],
              ),
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: students.length,
      ),
    );
  }
}
