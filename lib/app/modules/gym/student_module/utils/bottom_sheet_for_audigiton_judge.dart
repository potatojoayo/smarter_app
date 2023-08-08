import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/audition_detail_controller.dart';
import 'package:smarter/app/modules/gym/student_module/mutations/audition_detail_pass.dart';

Future<void> bottomSheetForAuditionJudge(Function() refetch,
    Map<String, dynamic> detail) async {
  var textEditingController = TextEditingController();
  await Get.bottomSheet(Container(
    decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultText('심사를 하시겠습니까?', style: Get.theme.textTheme.bodyLarge),
          const SizedBox(
            height: 5,
          ),
          DefaultText(
            '메모를 남기고 심사를 해주세요',
            style: Get.theme.textTheme.labelMedium,
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
              style: Get.theme.textTheme.bodySmall,
              maxLength: 20,
              autofocus: true,
              textAlign: TextAlign.right,
              controller: textEditingController,
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10)),
              keyboardType: kIsWeb ? null : TextInputType.text),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: Get.back,
                  child: const DefaultText(
                    '취소',
                    style: TextStyle(color: textColor),
                  )),
              AuditionDetailPassMutation(
                  onComplete: refetch,
                  builder: (runMutation, result) {
                    return RoundedLoadingButton(
                        width: 70,
                        elevation: 0,
                        color: Colors.white,
                        valueColor: Get.theme.colorScheme.error,
                        onPressed: () {
                          runMutation({
                            'auditionDetailId': detail['id'],
                            'didPass': false,
                            'memo': textEditingController.text
                          });
                        },
                        controller:
                        AuditionDetailController.to.loadingButtonController,
                        child: const DefaultText(
                          '불합격',
                          style: TextStyle(color: errorColor, fontSize: 17),
                        ));
                  }),
              AuditionDetailPassMutation(
                  onComplete: refetch,
                  builder: (runMutation, result) {
                    return RoundedLoadingButton(
                        color: Colors.white,
                        valueColor: Get.theme.primaryColorDark,
                        elevation: 0,
                        width: 50,
                        onPressed: () {
                          runMutation({
                            'auditionDetailId': detail['id'],
                            'didPass': true,
                            'memo': textEditingController.text
                          });
                        },
                        controller: AuditionDetailController.to
                            .loadingButtonController,
                        child: const DefaultText('합격',
                        style: TextStyle(color: primaryColor, fontSize: 17)));
                  }),
            ],
          )
        ],
      ),
    ),
  ));
}
