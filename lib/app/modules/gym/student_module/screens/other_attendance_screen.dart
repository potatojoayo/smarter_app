import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/format_phone.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/gym_class_module/quries/classes.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_controller.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/other_class_attendance.dart';
import 'package:smarter/app/modules/gym/student_module/quries/students_query.dart';

class OtherAttendanceScreen extends StatelessWidget {
  const OtherAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: DefaultText(
          '타수업등원',
          style: Get.textTheme.bodySmall,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: OtherClassAttendanceMutation(
              builder: (runMutation, result) {
                if (result!.hasException) {
                  if (kDebugMode) {
                    print(result.exception);
                  }
                }
                return RoundedLoadingButton(
                  width: 50,
                  color: Colors.white,
                  valueColor: Get.theme.primaryColorDark,
                  elevation: 0,
                  controller: AttendanceController.to.loadingButtonController,
                  onPressed: () {
                    AttendanceController.to
                        .addOtherClassAttendance(runMutation);
                  },
                  child: DefaultText(
                    '추가',
                    style: TextStyle(
                        color: Get.theme.primaryColorDark, fontSize: 20),
                  ),
                );
              },
              onComplete: () {
                AttendanceController.to.loadingButtonController.stop();
                Get.back();
                showSnackBar('타수업등원 학생이 추가되었습니다.');
              },
            ),
          )
        ],
      ),
      body: Classes(builder: (classMasters, refetch) {
        return StudentsQuery(
            variables: {
              'class': AttendanceController.to.selectedClass.value ?? '_',
            },
            builder: (students, _, __, ___, fetchMore, _____) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Obx(() => DropdownButton2<String>(
                                  hint: DefaultText(
                                    '클래스',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                  value: AttendanceController
                                      .to.selectedClass.value,
                                  dropdownMaxHeight: 180,
                                  dropdownElevation: 0,
                                  dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[180]),
                                  items: classMasters
                                      .where((cls) =>
                                          cls['name'] !=
                                          AttendanceController
                                              .to.classMasterName)
                                      .map((cls) => DropdownMenuItem<String>(
                                            value: cls['name'],
                                            child: DefaultText(
                                              cls['name'],
                                              style: Get.textTheme.labelLarge,
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    AttendanceController
                                        .to.selectedClass.value = value!;
                                    FetchMoreOptions fetchMoreOptions =
                                        FetchMoreOptions(
                                            updateQuery:
                                                (previousData, newData) {
                                              return newData;
                                            },
                                            variables: {
                                          'class': value,
                                        });
                                    fetchMore!(fetchMoreOptions);
                                  },
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            final student = students[index];
                            return GestureDetector(
                              onTap: () {
                                if (AttendanceController.to.selectedStudentIds
                                        .firstWhereOrNull((element) =>
                                            student['studentId'] == element) ==
                                    null) {
                                  AttendanceController.to.selectedStudentIds
                                      .add(student['studentId']);
                                } else {
                                  AttendanceController.to.selectedStudentIds
                                      .removeWhere(
                                          (id) => id == student['studentId']);
                                }
                              },
                              child: Obx(
                                () => Container(
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: AttendanceController.to
                                            .isSelectedStudent(
                                                student['studentId'])
                                        ? Get.theme.primaryColorDark
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DefaultTextStyle(
                                    style: GoogleFonts.nanumGothic(
                                      color: AttendanceController.to
                                              .isSelectedStudent(
                                                  student['studentId'])
                                          ? Colors.white
                                          : textColor,
                                    ),
                                    child: Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      spacing: 15,
                                      runSpacing: 15,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const DefaultText(
                                              '이름',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            DefaultText(
                                              student['name'],
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const DefaultText(
                                              '클래스',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            DefaultText(
                                              student['classMaster']['name'],
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const DefaultText(
                                              '생일',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            DefaultText(
                                              student['birthday'],
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const DefaultText(
                                              '보호자 휴대폰',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            DefaultText(
                                              formatPhone(student['parent']
                                                  ['user']['phone']),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: students.length),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
