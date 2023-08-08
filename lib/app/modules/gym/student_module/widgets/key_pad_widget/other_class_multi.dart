import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/gym_class_module/quries/current_classes_query.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_key_pad_controller.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/other_class_attendance.dart';

class OtherClassMulti extends StatelessWidget {
  const OtherClassMulti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurrentClasses(builder: (List<Map<String, dynamic>> classMasters) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final classMaster = classMasters[index];
            return OtherClassAttendanceMutation(builder: (runMutation, result) {
              return GestureDetector(
                onTap: () {
                  runMutation({
                    'studentIds': AttendanceKeyPadController.to.studentId,
                    'attendanceMasterId': classMaster['id']
                  });
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
                        classMaster['name'],
                        style: Get.textTheme.bodySmall,
                      ),
                      Row(
                        children: [
                          DefaultText(
                            '${classMaster['currentClassDetail']['hourStart']}:${classMaster['currentClassDetail']['minStart'].toString().padLeft(2, '0')}',
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
                            '${classMaster['currentClassDetail']['hourEnd']}:${classMaster['currentClassDetail']['minEnd'].toString().padLeft(2, '0')}',
                            style: Get.textTheme.labelLarge,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }, onComplete: () {
              Get.back();
              showSnackBar('타수업(${classMaster['name']})으로 등원 되었습니다');
            });
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: classMasters.length,
        ),
      );
    });
  }
}
