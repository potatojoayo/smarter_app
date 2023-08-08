// import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/me_query.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_key_pad_controller.dart';

class AttendanceKeyPadScreen extends StatefulWidget {
  const AttendanceKeyPadScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceKeyPadScreen> createState() => _AttendanceKeyPadScreenState();
}

class _AttendanceKeyPadScreenState extends State<AttendanceKeyPadScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width - 60; // 패딩값
    final height = size.height - 20 - 50 - 70 - 55 - 25; //;
    final ratio = width * 1.5 / height;
    if (kDebugMode) {}

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    double childAspectRatio = isLandscape ? ratio : 1.15;

    return WillPopScope(
      onWillPop: () async => false,
      child: MeQuery(
        builder: (Map<String, dynamic> user, refetch) {
          return Scaffold(
              appBar: AppBar(
                title: DefaultText(
                  '${user['gym']['name']} 출결 키패드',
                  style: Get.textTheme.bodySmall,
                ),
                titleSpacing: 0,
                leading: Center(
                  child: GestureDetector(
                    onTap: () async {
                      await Get.defaultDialog(
                        title: '출결키패드 종료',
                        titlePadding: const EdgeInsets.only(
                          top: 20,
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 30, right: 30, top: 20),
                        content: Column(
                          children: [
                            DefaultText(
                              '종료 하시겠습니까?',
                              textAlign: TextAlign.center,
                              style: Get.textTheme.labelLarge,
                            ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // OutlinedTextField(
                            //   controller:
                            //       AttendanceKeyPadController.to.password,
                            //   minWidth: double.infinity,
                            //   obscureText: true,
                            //   hintText: '비밀번호',
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                      Get.back();
                                    },
                                    child: const DefaultText('네')),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: DefaultText(
                                      '아니오',
                                      style: TextStyle(
                                          color: Get.theme.colorScheme.error),
                                    )),
                              ],
                            )
                          ],
                        ),
                      );
                      AttendanceKeyPadController.to.password.clear();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const FaIcon(
                        FontAwesomeIcons.chevronLeft,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 4; i++)
                            Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 70,
                                  height: 70,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Obx(() => AttendanceKeyPadController
                                                    .to.code.value.length >
                                                i
                                            ? Image.asset(
                                                'assets/icon/snow_blue.png')
                                            : Image.asset(
                                                'assets/icon/snow_grey.png')
                                        //     DefaultText(
                                        //   AttendanceKeyPadController
                                        //               .to.code.value.length >
                                        //           i
                                        //       ? '•'
                                        //       : '',
                                        //   textAlign: TextAlign.center,
                                        //   style: TextStyle(
                                        //     fontSize: 32,
                                        //     color: primaryColor,
                                        //   ),
                                        // ),
                                        ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: childAspectRatio,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (_, index) {
                            late final Widget child;
                            if (index < 9) {
                              child = DefaultText(
                                (index + 1).toString(),
                                style: const TextStyle(fontSize: 30),
                              );
                            } else if (index == 9) {
                              child = const FaIcon(FontAwesomeIcons.xmark);
                            } else if (index == 10) {
                              child = const DefaultText(
                                '0',
                                style: TextStyle(fontSize: 30),
                              );
                            } else {
                              child = const FaIcon(FontAwesomeIcons.arrowLeft);
                            }
                            return InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                AttendanceKeyPadController.to.onTapKey(index);
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: child),
                              ),
                            );
                          },
                          itemCount: 12,
                        ),
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
