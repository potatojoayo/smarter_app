import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/open_kakao.dart';

class KakaoFloatingActionButton extends StatelessWidget {
  const KakaoFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 0,
        backgroundColor: Get.theme.primaryColorDark,
        onPressed: openKakao,
        child: Image.asset('assets/icon/counsel.png'),
      ),
    );
  }
}
