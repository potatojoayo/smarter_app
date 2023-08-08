import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/global/widgets/default_screen_padding.dart';
import 'package:smarter/app/global/widgets/outlined_textfield.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/my_page_module/change_password_mutation.dart';
import 'package:smarter/app/modules/my_page_module/controllers/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Mutation(
        options: MutationOptions(
            document: gql(ChangePasswordMutation.changePassword),
            onCompleted: (result) {
              if (result != null) {
                final invalid = result['changePassword']['invalid'];
                final success = result['changePassword']['success'];
                if (invalid) {
                  showSnackBar('현재 비밀번호가 잘못되었습니다.');
                  return;
                }
                if (success) {
                  Get.back();
                  showSnackBar('비밀번호가 변경되었습니다.');
                }
              }
            }),
        builder: (MultiSourceResult<Object?> Function(Map<String, dynamic>,
                    {Object? optimisticResult})
                runMutation,
            QueryResult<Object?>? result) {
          return Scaffold(
            bottomSheet: Container(
              color: Colors.white,
              child: DefaultScreenPadding(
                vertical: 10,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (ChangePasswordController
                              .to.currentPassword.text.isEmpty ||
                          ChangePasswordController
                              .to.changingPassword.text.isEmpty ||
                          ChangePasswordController
                              .to.checkPassword.text.isEmpty) {
                        showSnackBar('모든 항목을 입력해주세요.');
                        return;
                      }
                      if (ChangePasswordController.to.changingPassword.text !=
                          ChangePasswordController.to.checkPassword.text) {
                        showSnackBar('변경하실 비밀번호와 확인 비밀번호가 일치하지 않습니다.');
                        return;
                      }
                      runMutation({
                        'currentPassword':
                            ChangePasswordController.to.currentPassword.text,
                        'changingPassword':
                            ChangePasswordController.to.changingPassword.text
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.primaryColorDark),
                    child: const DefaultText('비밀번호 변경'),
                  ),
                ),
              ),
            ),
            body: CustomScrollView(
              slivers: [
                defaultAppBar(title: '비밀번호 변경', showActions: false),
                SliverToBoxAdapter(
                  child: DefaultScreenPadding(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutlinedTextField(
                          controller:
                              ChangePasswordController.to.currentPassword,
                          minWidth: double.infinity,
                          maxHeight: 50,
                          obscureText: true,
                          label: '현재 비밀번호',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedTextField(
                          controller:
                              ChangePasswordController.to.changingPassword,
                          minWidth: double.infinity,
                          maxHeight: 50,
                          obscureText: true,
                          label: '변경하실 비밀번호',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedTextField(
                          controller: ChangePasswordController.to.checkPassword,
                          minWidth: double.infinity,
                          maxHeight: 50,
                          obscureText: true,
                          label: '비밀번호 확인',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
