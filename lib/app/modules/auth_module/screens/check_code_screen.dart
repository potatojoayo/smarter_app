import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/global/widgets/text_field.dart';
import 'package:smarter/app/modules/auth_module/auth_mutation.dart';
import 'package:smarter/app/modules/auth_module/controllers/check_code_controller.dart';
import 'package:smarter/app/routes/routes.dart';

class CheckCodeScreen extends StatefulWidget {
  const CheckCodeScreen({Key? key}) : super(key: key);

  @override
  State<CheckCodeScreen> createState() => _CheckCodeScreenState();
}

class _CheckCodeScreenState extends State<CheckCodeScreen> {
  int _seconds = 200;
  bool _isRunning = false;
  late Timer _timer;

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds < 1) {
          _stopTimer();
          showSnackBar('인증 시간이 초과되었습니다');
          Get.offNamed(Routes.auth);
        }
      });
    });
  }

  void _stopTimer() {
    _isRunning = false;
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    if (!_isRunning) {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    // _startTimer();
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
                if (CheckCodeController.to.authCodeController.text == "") {
                  showSnackBar("인증코드를 입력해주세요");
                  CheckCodeController.to.loadingController.stop();
                  return;
                }

                CheckCodeController.to.loadingController.start();

                final result = await CheckCodeController.to.authClient.mutate(
                    MutationOptions(
                        document: gql(AuthMutation.checkCode),
                        variables: {
                      'code': CheckCodeController.to.authCodeController.text,
                      'identification': Get.arguments['identification'],
                      'phoneNumber': Get.arguments['phoneNumber'],
                    }));

                if (!result.hasException) {
                  if (result.data?['checkCode']['success']) {
                    Get.toNamed(Routes.newPassword, arguments: {
                      'userId': result.data?['checkCode']['userId']
                    });
                    CheckCodeController.to.authCodeController.text = '';
                    CheckCodeController.to.loadingController.stop();
                  } else {
                    showSnackBar(result.data?['checkCode']['message']);
                    CheckCodeController.to.loadingController.stop();
                  }
                } else {
                  showSnackBar('에러');
                  CheckCodeController.to.loadingController.stop();
                }
              },
              controller: CheckCodeController.to.loadingController,
              child: const Center(child: DefaultText('확인')),
            )),
        appBar: AppBar(
          title: DefaultText(
            '코드 인증',
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
                    controller: CheckCodeController.to.authCodeController,
                    label: '인증코드',
                    hint: '인증코드 여섯자리를 입력해주세요.',
                    textInputType: TextInputType.number,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 40,
                        ),
                        Text('남은시간 $_seconds 초',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
