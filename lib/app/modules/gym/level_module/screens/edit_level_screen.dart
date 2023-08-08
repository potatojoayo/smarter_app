import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/level_module/controllers/edit_level_controller.dart';
import 'package:smarter/app/modules/gym/level_module/mutations/create_or_update_level.dart';
import 'package:smarter/app/modules/gym/student_module/quries/classes_and_levels.dart';

class EditLevelScreen extends StatefulWidget {
  const EditLevelScreen({Key? key}) : super(key: key);

  @override
  State<EditLevelScreen> createState() => _EditLevelScreenState();
}

class _EditLevelScreenState extends State<EditLevelScreen> {
  List<String> classes = [];

  @override
  void initState() {
    super.initState();
    Client()
        .client
        .value
        .query(QueryOptions(document: gql(classesAndLevels)))
        .then((result) {
      classes.assignAll(
          List<String>.from(result.data!['myLevels'].map((c) => c['name'])));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        bottomSheet: CreateOrUpdateLevel(
          builder: (runMutation, result) {
            return Container(
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  int.parse(Get.parameters['id']!) != -1
                      ? Expanded(
                          child: TextButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: '삭제',
                                titleStyle: TextStyle(
                                    color: Get.theme.colorScheme.error,
                                    fontSize: 15),
                                titlePadding: const EdgeInsets.only(top: 15),
                                content: DefaultText(
                                  '정말 급수를 삭제하시겠습니까?',
                                  style: Get.textTheme.labelLarge,
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                confirm: RoundedLoadingButton(
                                    width: 50,
                                    color: Colors.white,
                                    valueColor: Get.theme.primaryColorDark,
                                    elevation: 0,
                                    controller: EditLevelController
                                        .to.loadingButtonController,
                                    onPressed: () => EditLevelController.to
                                        .delete(runMutation),
                                    child: const DefaultText(
                                      '네',
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 17),
                                    )),
                                cancel: TextButton(
                                  onPressed: () => Get.back(),
                                  child: DefaultText(
                                    '아니오',
                                    style: TextStyle(
                                        color: Get.theme.colorScheme.error),
                                  ),
                                ),
                              );
                            },
                            child: DefaultText(
                              '삭제',
                              style:
                                  TextStyle(color: Get.theme.colorScheme.error),
                            ),
                          ),
                        )
                      : Expanded(
                          child: TextButton(
                            onPressed: () => Get.back(),
                            child: DefaultText(
                              '취소',
                              style:
                                  TextStyle(color: Get.theme.colorScheme.error),
                            ),
                          ),
                        ),
                  Expanded(
                    child: RoundedLoadingButton(
                      width: 100,
                      color: Colors.white,
                      valueColor: Get.theme.primaryColorDark,
                      elevation: 0,
                      controller:
                          EditLevelController.to.loadingButtonController,
                      onPressed: () {
                        if(classes.contains(EditLevelController.to.nameController.text)&& EditLevelController.to.isCreating){
                          showSnackBar("이미 등록된 급수입니다.");
                          EditLevelController.to.loadingButtonController.stop();
                          return;
                        }
                        EditLevelController.to.save(runMutation);
                      },
                      child: DefaultText(
                        EditLevelController.to.isCreating ? '급수 생성' : '저장',
                        style:
                            const TextStyle(color: primaryColor, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        appBar: AppBar(
          title: DefaultText(
            EditLevelController.to.isCreating ? '급수 생성' : '급수 수정',
            style: Get.textTheme.bodySmall,
          ),
          titleSpacing: 0,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: DefaultScreenPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedTextField(
                  controller: EditLevelController.to.nameController,
                  minWidth: 200,
                  maxHeight: 50,
                  label: '급수명칭',
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedTextField(
                  controller: EditLevelController.to.beltController,
                  label: '띠명칭',
                  maxHeight: 50,
                  minWidth: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedTextField(
                  controller: EditLevelController.to.beltColorController,
                  label: '띠색상',
                  maxHeight: 50,
                  minWidth: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedTextField(
                  controller: EditLevelController.to.beltBrandController,
                  label: '사용띠브랜드',
                  maxHeight: 50,
                  minWidth: 200,
                ),
                const SizedBox(
                  height: 300,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
