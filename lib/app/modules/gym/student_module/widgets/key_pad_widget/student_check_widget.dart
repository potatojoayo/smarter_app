

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_key_pad_controller.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/attendance_for_student.dart';

class  StudentCheckWidget extends StatelessWidget {
  const StudentCheckWidget({Key? key, required this.students}) : super(key: key);

  final List<Map<String, dynamic>> students;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        late final Map<String, dynamic>
        student;
        try {
          student = students.firstWhere(
                  (s) =>
              s['id'] ==
                  AttendanceKeyPadController.to.studentId.toString());
        } catch (_) {
          student = students[0];
        }
        return Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius:
            BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  DefaultText(
                    student['name'],
                    style: const TextStyle(
                        fontSize: 40),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const DefaultText(
                    '학생',
                    style: TextStyle(
                        fontSize: 30),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const DefaultText(
                '본인이 맞나요?',
                style:
                TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                children: [
                  AttendanceForStudentMutation(
                    builder: (MultiSourceResult<dynamic> Function(
                        Map<String,
                            dynamic>,
                        {Object?
                        optimisticResult})
                    runMutation,
                        QueryResult<
                            Object?>?
                        result) {
                      return GestureDetector(
                        onTap: () {
                          runMutation({
                            'studentId':
                            AttendanceKeyPadController.to.studentId,
                            'classMasterId':
                            1
                          });
                        },
                        child: Container(
                          padding:
                          const EdgeInsets
                              .all(15),
                          width: 100,
                          decoration:
                          BoxDecoration(
                            color: Get.theme
                                .primaryColorDark,
                            borderRadius:
                            BorderRadius
                                .circular(
                                10),
                          ),
                          child:
                          const Center(
                            child:
                            DefaultText(
                              '네',
                              style:
                              TextStyle(
                                fontSize:
                                25,
                                color: Colors
                                    .white,
                              ),
                              textAlign:
                              TextAlign
                                  .center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding:
                      const EdgeInsets
                          .all(15),
                      width: 100,
                      decoration:
                      BoxDecoration(
                        color: Get
                            .theme
                            .colorScheme
                            .error,
                        borderRadius:
                        BorderRadius
                            .circular(
                            10),
                      ),
                      child: const Center(
                        child: DefaultText(
                          '아니오',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors
                                  .white),
                          textAlign:
                          TextAlign
                              .center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
