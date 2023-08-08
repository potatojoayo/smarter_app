import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/open_kakao.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';
import 'package:smarter/app/modules/auth_module/widgets/login_form.dart';
import 'package:smarter/app/modules/auth_module/widgets/register_button.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset('assets/icon/v2_logo.png'),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DefaultText(
                          'Grassroots Sports Business Platform',
                          style: TextStyle(
                              color: Get.theme.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                const LoginForm(),
                const SizedBox(
                  height: 10,
                ),
                RegisterButton(
                  onPressed: () {
                    Get.toNamed(Routes.register);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.findPassword);
                      },
                      child: Text(
                        '비밀번호 재설정',
                        style: TextStyle(
                            color: Get.theme.primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                    Row(
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
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                DefaultTextStyle(
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: '대표번호 1533 - 4147\n',
                          style: TextStyle(
                              color: textColor, fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: '계속 진행하시는 경우 스마터의 '),
                        TextSpan(
                          text: '이용약관',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              final Uri url = Uri.parse(
                                  'https://blocket.co.kr/asset/smarter_agreement.html');
                              launchUrl(url);
                            },
                          style: const TextStyle(
                              decoration: TextDecoration.underline),
                        ),
                        const TextSpan(text: '에 동의하고 스마터의 '),
                        TextSpan(
                          text: '개인정보 사용 동의 정책',
                          style: const TextStyle(
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              final Uri url = Uri.parse(
                                  'https://blocket.co.kr/asset/smarter_privacy.html');
                              launchUrl(url);
                            },
                        ),
                        const TextSpan(text: '을 읽었음을 확인한 것으로 간주합니다.'),
                      ],
                    ),
                    style: const TextStyle(height: 2),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultText(
                        "버전 ${AuthController.to.version.value}",
                        style: const TextStyle(
                            color: textLight,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
