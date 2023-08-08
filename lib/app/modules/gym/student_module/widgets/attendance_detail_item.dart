import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_controller.dart';
import 'package:smarter/app/modules/gym/student_module/utils/get_attendance_color.dart';

class AttendanceDetailItem extends StatelessWidget {
  const AttendanceDetailItem({
    Key? key,
    required this.detail,
  }) : super(key: key);

  final Map<String, dynamic> detail;

  @override
  Widget build(BuildContext context) {
    final student = detail['student'];
    final id = int.parse(detail['id']);
    return GestureDetector(
      onTap: () {
        if (AttendanceController.to.isSelected(id)) {
          AttendanceController.to.selected.removeWhere((s) => s == id);
        } else {
          AttendanceController.to.selected.add(id);
        }
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, offset: Offset(1, 1), blurRadius: 4)
              ],
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DefaultText(
                      student['name'],
                      style: Get.textTheme.labelLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    DefaultText(
                      student['birthday'],
                      style: Get.textTheme.labelMedium,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    DefaultText(
                      student['gender'],
                      style: Get.textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: getAttendanceColor(detail['type']),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DefaultText(
                    detail['type'] ?? '미등원',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
          Obx(
            () => Container(
              decoration: BoxDecoration(
                color: AttendanceController.to.isSelected(id)
                    ? Get.theme.primaryColorDark.withOpacity(0.4)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
