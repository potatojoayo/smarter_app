import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/phone_formatter.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_nav_student_controller.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentListItem extends StatelessWidget {
  const StudentListItem({
    Key? key,
    required this.student,
  }) : super(key: key);

  final Map<String, dynamic> student;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result =
            await Get.toNamed('${Routes.student}/${student['studentId']}');
        if (result != null) {
          GymNavStudentController.to.refetch();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(2, 2), blurRadius: 8),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            student['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DefaultText(
                                student['birthday']
                                    .toString()
                                    .replaceAll('-', '.'),
                                style: const TextStyle(
                                    color: textLight,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              DefaultText(
                                student['gender'],
                                style: const TextStyle(
                                    color: textLight,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColorDark,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: DefaultText(
                      student['classMaster']['name'],
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const DefaultText(
                    '보호자명',
                    style: TextStyle(
                        color: textLight,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  DefaultText(
                    student['parent']['user']['name'],
                    style: Get.textTheme.labelLarge,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultText(
                    student['level']['name'],
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: student['status'] == '수강중'
                          ? const Color(0xFFF1F8FE)
                          : const Color(0xFFFBF3DA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DefaultText(
                      student['status'],
                      style: TextStyle(
                          fontSize: 15,
                          color: student['status'] == '수강중'
                              ? Get.theme.primaryColor
                              : const Color(0xFFB77D36)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // DefaultText(
                  //   '보호자 연락처',
                  //   style: Get.textTheme.labelMedium,
                  // ),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                          "tel:${student['parent']['user']['phone']}");
                      if (await canLaunchUrl(url)) {
                        launchUrl(url);
                      } else {
                        // ignore: avoid_print
                        print("Can't launch $url");
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const DefaultText(
                          '보호자 연락처',
                          style: TextStyle(
                              color: textLight,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // const FaIcon(
                            //   FontAwesomeIcons.circlePhone,
                            //   size: 20,
                            // ),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            DefaultText(
                              phoneFormatter
                                  .maskText(student['parent']['user']['phone']),
                              style: const TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
