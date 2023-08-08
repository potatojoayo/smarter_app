import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: AuthController.to.idController,
            style: Get.textTheme.bodySmall,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Get.theme.primaryColor),
                  borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100),
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(
                '아이디',
                style: Get.textTheme.labelSmall,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            style: Get.textTheme.bodySmall,
            textInputAction: TextInputAction.done,
            obscureText: true,
            controller: AuthController.to.passwordController,
            onFieldSubmitted: (value) async {
              await AuthController.to.login();
            },
            validator: (value) {
              if (value!.length < 4) {
                return '비밀번호는 4자 이상이어야 합니다.';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              errorStyle: const TextStyle(
                color: errorColor,
                fontSize: 13,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Get.theme.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100),
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(
                '비밀번호',
                style: Get.textTheme.labelSmall,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Obx(
                () => GFCheckbox(
                  size: 20,
                  value: AuthController.to.isAutoLogin.value,
                  onChanged: (value) {
                    AuthController.to.isAutoLogin.value = value;
                  },
                  inactiveIcon: Image.asset("assets/icon/v2_unchecked.png"),
                  activeIcon: Image.asset("assets/icon/v2_checked.png"),
                  activeBgColor: GFColors.TRANSPARENT,
                  inactiveBorderColor: GFColors.TRANSPARENT,
                  activeBorderColor: GFColors.TRANSPARENT,
                ),
              ),
              const Text('자동로그인',
                  style: TextStyle(
                      color: textLight,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: GestureDetector(
              onTap: () {
                AuthController.to.login();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Get.theme.primaryColorDark,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: DefaultText(
                    '로그인',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
