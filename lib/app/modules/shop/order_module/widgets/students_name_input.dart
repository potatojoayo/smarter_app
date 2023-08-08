import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/quries/students_query.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_option_controller.dart';

class StudentNameInput extends StatelessWidget {
  const StudentNameInput({
    super.key,
    required this.controller,
  });

  final SpeedOrderOptionController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
                child: TextField(
                  style: const TextStyle(fontSize: 18),
                  onSubmitted: (name) {
                    controller.studentNames.add({'name': name, 'count': 1.obs});
                    controller.quantity += 1;
                    controller.quantityController.text =
                        controller.quantity.toString();
                    controller.studentListController.clear();
                  },
                  controller: controller.studentListController,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF3A4D56),
                border: Border.all(width: 1),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: GestureDetector(
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
                            // 'first': 5,
                          },
                          builder: (List<Map<String, dynamic>> students,
                              bool hasNextPage,
                              String? endCursor,
                              int totalCount,
                              Function(FetchMoreOptions)? fetchMore,
                              Function()? refetch) {
                            controller.fetchMoreStudents = fetchMore;
                            controller.selectedCheckList.value =
                                List<bool>.generate(
                                    students.length, (index) => false);

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
                                      List? newStudents =
                                          List<Map<String, dynamic>>.from(
                                              result!['myStudents']['edges']);
                                      final List<Map<String, dynamic>>
                                          students = [
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
                                appBar: AppBar(
                                  automaticallyImplyLeading: false,
                                  title: const Text(
                                    '원생데이터',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ),
                                body: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          // color: Color(0xFFF0F3FE),
                                          padding: const EdgeInsets.all(16),
                                          child: ListView.separated(
                                            separatorBuilder: (_, __) =>
                                                const SizedBox(
                                              height: 10,
                                            ),
                                            physics: const ScrollPhysics(),
                                            itemCount: students.length + 1,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              if (index < students.length) {
                                                final student = students[index];
                                                return Row(
                                                  children: [
                                                    Obx(
                                                      () => Checkbox(
                                                        value: controller
                                                                .selectedCheckList[
                                                            index],
                                                        onChanged: (value) {
                                                          controller
                                                                  .selectedCheckList[
                                                              index] = value;
                                                          controller
                                                              .selectedCheckList
                                                              .refresh();
                                                        },
                                                      ),
                                                    ),
                                                    Text(
                                                      student['name'],
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                );
                                              }
                                              return hasNextPage
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SpinKitChasingDots(
                                                        color: Get.theme
                                                            .primaryColorDark,
                                                      ),
                                                    )
                                                  : Container();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                bottomNavigationBar: ElevatedButton(
                                  onPressed: () {
                                    // controller.studentNames.clear();
                                    for (int i = 0;
                                        i <
                                            controller
                                                .selectedCheckList.value.length;
                                        i++) {
                                      if (controller
                                          .selectedCheckList.value[i]) {
                                        controller.studentNames.add({
                                          'name': students[i]['name'],
                                          'count': 1.obs
                                        });
                                      }
                                    }
                                    controller.studentNames.refresh();
                                    Get.back();
                                  },
                                  child: const Text('입력하기'),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.window,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      '원생정보',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Obx(
          () => Wrap(
            runSpacing: -5,
            children: [
              for (var i = 0; i < controller.studentNames.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 3.0),
                  child: Chip(
                    label: DefaultText(
                      controller.studentNames[i]['name'],
                      style: Get.textTheme.labelMedium,
                    ),
                    deleteIcon: const FaIcon(
                      FontAwesomeIcons.x,
                      size: 12,
                    ),
                    onDeleted: () {
                      controller.studentNames.removeAt(i);
                      controller.quantity -= 1;
                      controller.quantityController.text =
                          controller.quantity.toString();
                    },
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
