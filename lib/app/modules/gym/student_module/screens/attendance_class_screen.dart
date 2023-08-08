import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/day.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/gym_class_module/quries/classes.dart';
import 'package:smarter/app/routes/routes.dart';

class AttendanceClassScreen extends StatelessWidget {
  const AttendanceClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Classes(
        builder: (classMasters, refetch) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final classMaster = classMasters[index];
                  return GestureDetector(
                    onTap: () async {
                      Get.toNamed(
                          '${Routes.attendanceMaster}/${classMaster['id']}');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(1, 1),
                              blurRadius: 4)
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                '클래스명',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[500]),
                              ),
                              DefaultText(
                                classMaster['name'],
                                style: Get.textTheme.labelLarge,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              for (var detail in classMaster['classDetails'])
                                DefaultText(
                                  '${getDay(detail['day'])} ${detail['hourStart']}:${detail['minStart'].toString().padLeft(2, '0')} ~ ${detail['hourEnd']}:${detail['minEnd'].toString().padLeft(2, '0')}',
                                  style: Get.textTheme.labelMedium,
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: classMasters.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
