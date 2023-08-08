import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/audition_detail_controller.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/delete_audition_master.dart';
import 'package:smarter/app/modules/gym/student_module/quries/audition_query.dart';
import 'package:smarter/app/modules/gym/student_module/utils/is_all_auditions_over.dart';
import 'package:smarter/app/modules/gym/student_module/utils/bottom_sheet_for_audition_over.dart';
import 'package:smarter/app/modules/gym/student_module/widgets/audition_detail_item.dart';
import 'package:smarter/app/modules/gym/student_module/widgets/audition_item.dart';

class AuditionDetailScreen extends StatefulWidget {
  const AuditionDetailScreen({Key? key}) : super(key: key);

  @override
  State<AuditionDetailScreen> createState() => _AuditionDetailScreenState();
}

class _AuditionDetailScreenState extends State<AuditionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return AuditionMasterQuery(
        variables: {'id': Get.parameters['id']},
        builder: (audition, refetch) {
          final details = audition['details'];
          return Scaffold(
              appBar: AppBar(
                title: DefaultText(
                  '승급관리',
                  style: Get.textTheme.bodySmall,
                ),
                titleSpacing: 0,
                centerTitle: false,
                actions: [
                  DeleteAuditionMasterMutation(
                    builder: (runMutation, result) {
                      return TextButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: "승급 삭제",
                              titlePadding: const EdgeInsets.only(top: 20),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              titleStyle: Get.textTheme.labelMedium,
                              content: DefaultText(
                                '승급을 삭제하시겠습니까?',
                                style: Get.textTheme.labelLarge,
                              ),
                              cancel: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const DefaultText(
                                    '아니오',
                                    style: TextStyle(
                                        color: errorColor, fontSize: 16),
                                  ),
                                ),
                              ),
                              confirm: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: RoundedLoadingButton(
                                  width: 50,
                                  color: Colors.white,
                                  elevation: 0,
                                  valueColor: Get.theme.primaryColorDark,

                                  onPressed: () async {
                                    runMutation({'id': Get.parameters['id']});
                                  },
                                  controller: AuditionDetailController.to.loadingButtonController,
                                  child: DefaultText(
                                    '네',
                                    style: TextStyle(
                                        color: Get.theme.primaryColorDark,
                                        fontSize: 19),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const DefaultText(
                            '승급 삭제',
                            style: TextStyle(color: errorColor),
                          ));
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10,
                  bottom: 10,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AuditionItem(audition: audition),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          Map<String, dynamic> detail = details[index];
                          return AuditionDetailItem(
                              refetch: refetch,
                              detail: detail,
                              audition: audition);
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: details.length,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      details.length == 0
                          ? const Text("학생 없음")
                          : audition['state'] == '진행중' &&
                                  isAllAuditionsOver(audition['details'])
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Get.theme.primaryColorDark),
                                  onPressed: () {
                                    bottomSheetForAuditionOver(
                                        refetch, audition);
                                  },
                                  child: const Text('완료'))
                              : Container()
                    ],
                  ),
                ),
              ));
        });
  }
}
