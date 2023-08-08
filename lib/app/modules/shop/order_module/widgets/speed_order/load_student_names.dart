import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/quries/students_query.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_option_controller.dart';

class LoadStudentNames extends StatefulWidget {
  const LoadStudentNames({Key? key, required this.controller})
      : super(key: key);
  final SpeedOrderItemOptionController controller;

  @override
  State<LoadStudentNames> createState() => _LoadStudentNamesState();
}

class _LoadStudentNamesState extends State<LoadStudentNames> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          AlertDialog(
            content: SizedBox(
              height: 400,
              width: 200,
              child: StudentsQuery(
                variables: const {
                  'name': '',
                  'school': '',
                },
                builder: (List<Map<String, dynamic>> students,
                    bool hasNextPage,
                    String? endCursor,
                    int totalCount,
                    Function(FetchMoreOptions)? fetchMore,
                    Function()? refetch) {
                  return NotificationListener<ScrollEndNotification>(
                    onNotification: (t) {
                      final fetchMoreOptions = FetchMoreOptions(
                          variables: {
                            'after': endCursor,
                            'first': 20,
                          },
                          updateQuery: (previous, result) {
                            List? previousStudents =
                                List<Map<String, dynamic>>.from(
                                    previous!['myStudents']['edges']);
                            List? newStudents = List<Map<String, dynamic>>.from(
                                result!['myStudents']['edges']);
                            final List<Map<String, dynamic>> students = [
                              ...previousStudents,
                              ...newStudents
                            ];
                            result['myStudents']['edges'] = students;
                            return result;
                          });
                      final metrics = t.metrics;
                      if (metrics.atEdge) {
                        bool isTop = metrics.pixels == 0;
                        if (!isTop && hasNextPage) {
                          fetchMore!(fetchMoreOptions);
                        }
                      }
                      return true;
                    },
                    child: Scaffold(
                      bottomSheet: Container(
                        color: backgroundColor,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Get.theme.primaryColorDark,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DefaultText(
                                  '완료',
                                  style: TextStyle(color: backgroundColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            children: [
                              const Text(
                                '원생데이터',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ListView.builder(
                                physics: const ScrollPhysics(),
                                itemCount: students.length + 1,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  if (index < students.length) {
                                    final student = students[index];
                                    return GestureDetector(
                                      onTap: () {
                                        final value = widget.controller
                                            .isChecked(student['name'])
                                            .value;
                                        if (!value) {
                                          widget.controller.addStudent(student);
                                        } else {
                                          widget.controller
                                              .removeStudent(student);
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Obx(() => Checkbox(
                                                value: widget.controller
                                                    .isChecked(student['name'])
                                                    .value,
                                                onChanged: (value) {
                                                  if (value!) {
                                                    widget.controller
                                                        .addStudent(student);
                                                  } else {
                                                    widget.controller
                                                        .removeStudent(student);
                                                  }
                                                },
                                              )),
                                          Text(
                                            student['name'],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return hasNextPage
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SpinKitChasingDots(
                                            color: Get.theme.primaryColorDark,
                                          ),
                                        )
                                      : Container();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Get.theme.primaryColorDark),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.window,
              color: Colors.white,
              size: 12,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '원생정보 단체등록',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
