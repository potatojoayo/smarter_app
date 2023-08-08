import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/audition_detail_controller.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/audition_detail_pass.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/delete_audition_detail.dart';
import 'package:smarter/app/modules/gym/student_module/utils/bottom_sheet_for_audigiton_judge.dart';

class AuditionDetailItem extends StatelessWidget {
  const AuditionDetailItem(
      {Key? key,
      required this.refetch,
      required this.detail,
      required this.audition})
      : super(key: key);

  final Function() refetch;
  final Map<String, dynamic> detail;
  final Map<String, dynamic> audition;

  @override
  Widget build(BuildContext context) {
    return AuditionDetailPassMutation(
        onComplete: refetch,
        builder: (runMutation, result) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            DefaultText(detail['student']['name']),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Get.theme.primaryColorDark,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DefaultText(
                                detail['student']['classMaster']['name'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            DefaultText(
                              detail['student']['gender'],
                              style: Get.textTheme.labelMedium,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DefaultText(
                              detail['student']['birthday'],
                              style: Get.textTheme.labelMedium,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DefaultText(
                          detail['memo'] ?? "",
                          style: Get.textTheme.labelMedium,
                        ),
                      ],
                    ),
                    detail['didPass'] == null
                        ? GestureDetector(
                            onTap: () {
                              bottomSheetForAuditionJudge(refetch, detail);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                  color: greyColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const DefaultText(
                                '심사',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              if (audition['state'] == '완료') {
                                return showSnackBar('완료된 승급은 심사를 취소할 수 없습니다.');
                              }
                              Get.defaultDialog(
                                title: "심사취소",
                                titlePadding: const EdgeInsets.only(top: 20),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 30,
                                ),
                                titleStyle: Get.textTheme.labelMedium,
                                content: DefaultText(
                                  '심사를 취소하시겠습니까?',
                                  style: Get.textTheme.labelLarge,
                                ),
                                cancel: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const DefaultText(
                                      '아니오',
                                      style: TextStyle(
                                        color: errorColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                confirm: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      runMutation({
                                        'auditionDetailId': detail['id'],
                                        'didPass': null,
                                        'memo': ''
                                      });
                                      Get.back();
                                      showSnackBar('선택하신 학생의 심사가 취소되었습니다.');
                                    },
                                    child: DefaultText(
                                      '네',
                                      style: TextStyle(
                                        color: Get.theme.primaryColorDark,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: detail['didPass']
                                    ? Get.theme.primaryColorDark
                                    : Get.theme.colorScheme.error,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DefaultText(
                                detail['didPass'] ? '합격' : '불합격',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
              Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          title: '승급 삭제',
                          titleStyle: TextStyle(
                              color: Get.theme.colorScheme.error, fontSize: 15),
                          titlePadding: const EdgeInsets.only(top: 16),
                          content: DefaultText(
                            '${detail['student']['name']}의 승급을 삭제하시겠습니까?',
                            style: Get.textTheme.labelLarge,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          confirm: DeleteAuditionDetailMutation(
                            builder: (runMutation, result) {
                              return Container(
                                padding: const EdgeInsets.only(top: 2),
                                height: 20,
                                width: 70,
                                child: Center(
                                  child: RoundedLoadingButton(
                                    elevation: 0,
                                    height: 25,
                                    color: Colors.transparent,
                                    valueColor: Colors.red,
                                    controller: AuditionDetailController
                                        .to.loadingButtonController,
                                    onPressed: () {
                                      AuditionDetailController.to.deleteDetail(
                                          runMutation, detail['id']);
                                    },
                                    child: const DefaultText(
                                      '삭제',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          cancel: const SizedBox(
                            height: 20,
                            width: 70,
                            child: Center(
                              child: Text(
                                '아니오',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ));
                    },
                    child: const Icon(
                      FontAwesomeIcons.solidCircleX,
                      size: 15,
                    ),
                  ))
            ],
          );
        });
  }
}
