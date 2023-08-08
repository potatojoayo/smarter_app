import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';

class FindButtons extends StatelessWidget {
  const FindButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: DefaultText(
            '아이디 찾기',
            style: Get.textTheme.labelSmall,
          ),
        ),
        DefaultText(
          '|',
          style: Get.textTheme.labelSmall,
        ),
        TextButton(
          onPressed: () {},
          child: DefaultText(
            '비밀번호 재설정',
            style: Get.textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}
