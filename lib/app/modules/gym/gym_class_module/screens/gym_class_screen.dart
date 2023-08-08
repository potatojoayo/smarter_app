import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/day.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/gym_class_module/quries/classes.dart';
import 'package:smarter/app/routes/routes.dart';

class GymClassScreen extends StatelessWidget {
  const GymClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Classes(
      builder: (classMasters, refetch) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: DefaultText(
              '클래스 관리',
              style: Get.textTheme.bodySmall,
            ),
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: () async {
                    await Get.toNamed('${Routes.gymClass}/-1');
                    refetch!();
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.plus,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final classMaster = classMasters[index];
                  return GestureDetector(
                    onTap: () async {
                      await Get.toNamed(
                          '${Routes.gymClass}/${classMaster['id']}');
                      refetch!();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[100]),
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
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     DefaultText(
                          //       '원비',
                          //       style: TextStyle(
                          //           fontSize: 10, color: Colors.grey[500]),
                          //     ),
                          //     DefaultText(
                          //       formatMoney(classMaster['price']),
                          //       style: Get.textTheme.labelLarge,
                          //     ),
                          //   ],
                          // ),
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
          ),
        );
      },
    );
  }
}
