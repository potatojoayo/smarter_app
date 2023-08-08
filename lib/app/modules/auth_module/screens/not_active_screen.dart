import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';

class NotActiveScreen extends StatelessWidget {
  const NotActiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DefaultText(
          '회원가입 승인대기',
          style: Get.textTheme.bodyMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              '회원님의 계정이 \n회원가입 승인대기중입니다.',
              overflow: TextOverflow.visible,
              style: Get.textTheme.bodySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            DefaultText(
              '관리자의 승인 후 \n앱을 사용하실 수 있습니다.',
              overflow: TextOverflow.visible,
              style: Get.textTheme.bodySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            DefaultText(
              '조금만 더 기다려주세요.',
              overflow: TextOverflow.visible,
              style: Get.textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
