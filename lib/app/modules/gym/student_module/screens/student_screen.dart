import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/me_query.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_nav_student_controller.dart';
import 'package:smarter/app/modules/gym/student_module/quries/classes_and_levels.dart';
import 'package:smarter/app/modules/gym/student_module/quries/students_query.dart';
import 'package:smarter/app/modules/gym/student_module/widgets/class_dropdown_button.dart';
import 'package:smarter/app/modules/gym/student_module/widgets/level_dropdown_button.dart';
import 'package:smarter/app/modules/gym/student_module/widgets/student_list_item.dart';
import 'package:smarter/app/routes/routes.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  void initState() {
    super.initState();
    Client()
        .client
        .value
        .query(QueryOptions(document: gql(classesAndLevels)))
        .then((result) {
      if (result.data != null) {
        GymNavStudentController.to.classes.assignAll(
            List<String>.from(result.data!['myClasses'].map((c) => c['name'])));
        GymNavStudentController.to.classes.insert(0, '클래스');

        GymNavStudentController.to.levels.assignAll(
            List<String>.from(result.data!['myLevels'].map((l) => l['name'])));
        GymNavStudentController.to.levels.insert(0, '급수');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StudentsQuery(
      variables: {
        'class': GymNavStudentController.to.selectedClass.value != '클래스'
            ? GymNavStudentController.to.selectedClass.value
            : null,
        'level': GymNavStudentController.to.selectedLevel.value != '급수'
            ? GymNavStudentController.to.selectedLevel.value
            : null,
        // 'name': GymNavStudentController.to.name.value,
        // 'school': GymNavStudentController.to.school.value,
        'name': GymNavStudentController.to.selectedOption.value == '학생명'
            ? GymNavStudentController.to.searchOptionController.text
            : '',
        'school': GymNavStudentController.to.selectedOption.value == '학생명'
            ? ''
            : GymNavStudentController.to.searchOptionController.text,
        'first': 10,
      },
      builder: (List<Map<String, dynamic>> students,
          bool hasNextPage,
          String? endCursor,
          int totalCount,
          Function(FetchMoreOptions)? fetchMore,
          Function()? refetch) {
        GymNavStudentController.to.fetchMoreStudents = fetchMore;

        return NotificationListener<ScrollEndNotification>(
          onNotification: (t) {
            final fetchMoreOptions = FetchMoreOptions(
                variables: {
                  'after': endCursor,
                  'first': 10,
                },
                updateQuery: (previous, result) {
                  List? previousStudents = List<Map<String, dynamic>>.from(
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      ClassDropdownButton(),
                      SizedBox(
                        width: 20,
                      ),
                      LevelDropdownButton(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              Obx(
                                () => DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    hint: DefaultText(
                                      '전체',
                                      style: Get.textTheme.labelLarge,
                                    ),
                                    dropdownElevation: 0,
                                    dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(1, 1),
                                              spreadRadius: 1)
                                        ]),
                                    value: GymNavStudentController
                                        .to.selectedOption.value,
                                    items: GymNavStudentController
                                        .to.searchOptions
                                        .map(
                                          (option) => DropdownMenuItem<String>(
                                            value: option,
                                            child: Text(
                                              option,
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      GymNavStudentController.to.selectedOption
                                          .value = value.toString();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Container(
                                width: 1,
                                height: 25,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(
                                width: 80,
                                child: TextFormField(
                                  controller: GymNavStudentController
                                      .to.searchOptionController,
                                  textInputAction: TextInputAction.next,
                                  style: Get.textTheme.bodySmall,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  GymNavStudentController.to.refetch();
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        MeQuery(
                          builder: (Map<String, dynamic> user, refetchMe) {
                            return GestureDetector(
                              onTap: () async {
                                if (user['gym']['refundBankName'] == null ||
                                    user['gym']['refundBankName'].isEmpty ||
                                    user['gym']['refundBankOwnerName'] ==
                                        null ||
                                    user['gym']['refundBankOwnerName']
                                        .isEmpty ||
                                    user['gym']['refundBankAccountNo'] ==
                                        null ||
                                    user['gym']['refundBankAccountNo']
                                        .isEmpty) {
                                  showSnackBar(
                                      '원생을 추가하시려면 먼저 은행정보를 모두 입력해주세요.');
                                  await Get.toNamed(Routes.editMyInfo);
                                  return refetchMe();
                                }
                                final result =
                                    await Get.toNamed('${Routes.student}/-1');
                                if (result != null) {
                                  GymNavStudentController.to.refetch();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Get.theme.primaryColorDark,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.solidPlus,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    DefaultText(
                                      '원생추가',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 10,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: students.length + 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index < students.length) {
                          final student = students[index];
                          return StudentListItem(student: student);
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
