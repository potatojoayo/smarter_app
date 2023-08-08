

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_key_pad_controller.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/other_class_attendance.dart';

class  OtherClassOnlyOne extends StatelessWidget {
  const OtherClassOnlyOne({Key? key, required this.classMasters}) : super(key: key);

  final List<Map<String, dynamic>> classMasters;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              OtherClassAttendanceMutation(
                  builder: (runMutation, result) {
                    return GestureDetector(
                      onTap: () {
                        runMutation({
                          'studentIds':
                          AttendanceKeyPadController.to.studentId,
                          'attendanceMasterId':
                          int.parse(classMasters[0]['id'])
                        });
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
                    );
                  }, onComplete: () {
                Get.back();
                AttendanceKeyPadController.to.playAudio();
                showSnackBar(
                    '타수업(${classMasters[0]['name']})으로 등원 되었습니다');
              }),
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
    );
  }
}
