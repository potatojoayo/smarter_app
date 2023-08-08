import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/utils/phone_formatter.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/global/widgets/text_field.dart';
import 'package:smarter/app/modules/auth_module/auth_mutation.dart';
import 'package:smarter/app/modules/auth_module/controllers/find_password_controller.dart';
import 'package:smarter/app/routes/routes.dart';

class FindPasswordScreen extends StatelessWidget {
  const FindPasswordScreen({Key? key}) : super(key: key);

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
              onPressed: () async {
                FindPasswordController.to.loadingController.start();

                if (FindPasswordController.to.idController.text == '') {
                  showSnackBar('아이디를 입력해주세요');
                  FindPasswordController.to.loadingController.stop();
                  return;
                }

                if (FindPasswordController.to.phoneController.text == '') {
                  showSnackBar('전화번호를 입력해주세요');
                  FindPasswordController.to.loadingController.stop();
                  return;
                }

                final result =
                    await FindPasswordController.to.authClient.mutate(
                  MutationOptions(
                    document: gql(AuthMutation.sendCode),
                    variables: {
                      'identification':
                          FindPasswordController.to.idController.text,
                      'phoneNumber': FindPasswordController
                          .to.phoneController.text
                          .replaceAll('-', '')
                          .replaceAll(' ', ''),
                    },
                  ),
                );
                if (!result.hasException) {
                  if (result.data?['sendCode']['success']) {
                    Get.toNamed(Routes.checkCode, arguments: {
                      'identification':
                          FindPasswordController.to.idController.text,
                      'phoneNumber': FindPasswordController
                          .to.phoneController.text
                          .replaceAll('-', '')
                          .replaceAll(' ', ''),
                    });
                    FindPasswordController.to.idController.text = '';
                    FindPasswordController.to.phoneController.text = '';
                    FindPasswordController.to.loadingController.stop();
                  } else {
                    showSnackBar(result.data?['sendCode']['message']);
                    FindPasswordController.to.loadingController.stop();
                  }
                } else {
                  showSnackBar('에러');
                  FindPasswordController.to.loadingController.stop();
                }
              },
              controller: FindPasswordController.to.loadingController,
              child: const Center(child: DefaultText('비밀번호 재설정')),
            ),
          ),
          appBar: AppBar(
            title: DefaultText(
              '비밀번호 재설정',
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
                      controller: FindPasswordController.to.idController,
                      label: '아이디',
                      hint: '아이디를 입력해주세요.',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultTextField(
                      controller: FindPasswordController.to.phoneController,
                      label: '휴대폰 번호',
                      hint: '등록하신 휴대폰 번호를 입력해주세요.',
                      textInputType: TextInputType.phone,
                      inputFormatters: [phoneFormatter],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
