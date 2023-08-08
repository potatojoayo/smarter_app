import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/open_kakao.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/auth_module/controllers/register_controller.dart';
import 'package:smarter/app/modules/auth_module/widgets/register_button.dart';
import 'package:smarter/app/modules/auth_module/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DefaultText(
          '회원가입',
          style: Get.textTheme.bodyMedium,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          controller: RegisterController.to.scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RegisterForm(),
                const SizedBox(
                  height: 10,
                ),
                RegisterButton(
                  onPressed: RegisterController.to.register,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: openKakao,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icon/kakao.png',
                            scale: 22,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DefaultText(
                            '카카오톡 실시간 문의',
                            style: Get.textTheme.labelMedium,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const DefaultTextStyle(
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '대표번호 1533 - 4147\n',
                        ),
                        TextSpan(text: '계속 진행하시는 경우 스마터의 '),
                        TextSpan(
                          text: '이용약관',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                        TextSpan(text: '에 동의하고 스마터의 '),
                        TextSpan(
                          text: '개인정보 사용 동의 정책',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                        TextSpan(text: '을 읽었음을 확인한 것으로 간주합니다.'),
                      ],
                    ),
                    style: TextStyle(height: 2),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
