import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/day.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_controller.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/student_attendance.dart';
import 'package:smarter/app/modules/gym/student_module/utils/get_attendance_color.dart';
import 'package:smarter/app/modules/gym/student_module/widgets/attendance_detail_item.dart';
import 'package:smarter/app/routes/routes.dart';

import '../quries/attendance_master_query.dart';

class AttendanceDetailScreen extends StatelessWidget {
  const AttendanceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AttendanceMasterQuery(
      attendanceMasterId: Get.parameters['id']!,
      builder: (attendanceMaster, refetch) {
        if (kDebugMode) {
          print(attendanceMaster);
        }
        final date = DateTime.parse(attendanceMaster['date']);
        final details =
            List<Map<String, dynamic>>.from(attendanceMaster['details']);
        return Scaffold(
          appBar: AppBar(
            title: DefaultText(
              '출결관리',
              style: Get.textTheme.bodySmall,
            ),
            actions: [
              GestureDetector(
                onTap: () async {
                  await Get.toNamed(Routes.otherAttendance);
                  refetch();
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColorDark,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.plus,
                            color: Colors.white,
                            size: 13,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          DefaultText(
                            '타수업등원',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ],
            titleSpacing: 0,
            centerTitle: false,
          ),
          bottomSheet: Obx(
            () => AttendanceController.to.selected.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => SizedBox(
                                width: 25,
                                child: Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  value: AttendanceController
                                      .to.isAlarmEnabled.value,
                                  onChanged: (value) {
                                    AttendanceController
                                        .to.isAlarmEnabled.value = value!;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                AttendanceController.to.isAlarmEnabled.value =
                                    !AttendanceController
                                        .to.isAlarmEnabled.value;
                              },
                              child: DefaultText(
                                '출결내용 학부모에게 알림 보내기',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[600]),
                              ),
                            )
                          ],
                        ),
                        StudentAttendanceMutation(
                          builder: (MultiSourceResult<dynamic> Function(
                                      Map<String, dynamic>,
                                      {Object? optimisticResult})
                                  runMutation,
                              QueryResult<Object?>? result) {
                            return Row(
                              children: [
                                for (String type
                                    in AttendanceController.to.actionTypes)
                                  GestureDetector(
                                    onTap: () => AttendanceController.to
                                        .changeAttendance(type, runMutation),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: getAttendanceColor(type),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: DefaultText(
                                            type,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                          },
                          onComplete: () {
                            refetch();
                            AttendanceController.to.selected.clear();
                            AttendanceController.to.absentReason.clear();
                          },
                        )
                      ],
                    ),
                  ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(1, 1),
                            blurRadius: 6)
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              date.year.toString(),
                              style: Get.textTheme.labelMedium,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DefaultText(
                              '${date.month}/${date.day}',
                              style: Get.textTheme.labelLarge,
                            ),
                          ],
                        ),
                        DefaultText(
                          getDay(date.weekday - 1),
                          style: Get.textTheme.labelLarge,
                        ),
                        DefaultText(
                          attendanceMaster['classMaster']['name'],
                          style: Get.textTheme.labelLarge,
                        ),
                        DefaultText(
                          '${attendanceMaster['classDetail']['hourStart']}:${attendanceMaster['classDetail']['minStart'].toString().padLeft(2, '0')}',
                          style: Get.textTheme.labelLarge,
                        ),
                        DefaultText(
                          '~',
                          style: Get.textTheme.labelLarge,
                        ),
                        DefaultText(
                          '${attendanceMaster['classDetail']['hourEnd']}:${attendanceMaster['classDetail']['minEnd'].toString().padLeft(2, '0')}',
                          style: Get.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: details.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.1,
                      ),
                      itemBuilder: (_, index) {
                        final detail = details[index];
                        return AttendanceDetailItem(detail: detail);
                      }),
                  const SizedBox(
                    height: 110,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
