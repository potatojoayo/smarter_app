import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/global/widgets/text_field.dart';
import 'package:smarter/app/modules/auth_module/auth_mutation.dart';
import 'package:smarter/app/modules/auth_module/controllers/new_password_controller.dart';
import 'package:smarter/app/routes/routes.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          bottomSheet: Container(
            color: Colors.white,
            height: 60,
            padding: const EdgeInsets.all(8),
            child: RoundedLoadingButton(
              color: Get.theme.primaryColorDark,
              onPressed: () async{
                NewPasswordController.to.loadingController.start();

                if(NewPasswordController.to.newPasswordController.text.length <4){
                  showSnackBar('비밀번호는 4자리 이상입니다');
                  NewPasswordController.to.loadingController.stop();
                  return;
                }

                if(NewPasswordController.to.confirmPasswordController.text.length <4){
                  showSnackBar('비밀번호는 4자리 이상입니다');
                  NewPasswordController.to.loadingController.stop();
                  return;
                }

                final result = await NewPasswordController.to.authClient.mutate(
                    MutationOptions(document: gql(AuthMutation.setPassword),
                    variables: {
                      'userId': Get.arguments['userId'],
                      'newPassword': NewPasswordController.to.newPasswordController.text,
                      'confirmPassword': NewPasswordController.to.confirmPasswordController.text,
                    }));

                if (!result.hasException) {
                  if (result.data?['setPassword']['success']) {
                    Get.toNamed(Routes.auth);
                    showSnackBar(result.data?['setPassword']['message']);
                    NewPasswordController.to.loadingController.stop();
                  } else {
                    showSnackBar(result.data?['setPassword']['message']);
                    NewPasswordController.to.loadingController.stop();
                  }
                } else {
                  showSnackBar('에러');
                  NewPasswordController.to.loadingController.stop();
                }
              },
              controller: NewPasswordController.to.loadingController,
              child: const Center(child: DefaultText('확인')),
            ),
          ),
          appBar: AppBar(
            title: DefaultText(
              '새 비밀번호',
              style: Get.textTheme.bodySmall,
            ),
            centerTitle: false,
            titleSpacing: 0,
          ),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextField(
                      obscureText: true,
                      controller:
                      NewPasswordController.to.newPasswordController,
                      label: '새 비밀번호',
                      hint: '새로운 비밀번호를 입력해주세요.',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultTextField(
                      obscureText: true,
                      controller:
                      NewPasswordController.to.confirmPasswordController,
                      label: '비밀번호 확인',
                      hint: '한번 더 입력해주세요.',
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
