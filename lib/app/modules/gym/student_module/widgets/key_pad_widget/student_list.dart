import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_key_pad_controller.dart';
import 'package:smarter/app/modules/gym/student_module/quries/current_other_classes.dart';
import 'attendance_pad_student_list.dart';

class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudentsByCodeQuery(
      builder: (List<Map<String, dynamic>> students) {
        if (students.isEmpty) {
          return Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DefaultText(
                    '등록되지 않은 코드입니다.',
                    style: TextStyle(fontSize: 24, color: textColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 250,
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            AttendanceKeyPadController.to.code.value = '';
                            Get.back();
                          },
                          child: const DefaultText(
                            '닫기',
                            style: TextStyle(fontSize: 24),
                          )))
                ],
              )));
        }
        return AttendancePadStudentList(students: students);
      },
      code: AttendanceKeyPadController.to.code.value,
    );
  }
}
