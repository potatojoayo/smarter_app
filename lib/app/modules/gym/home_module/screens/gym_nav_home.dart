import 'package:flutter/material.dart';
import 'package:smarter/app/modules/gym/home_module/widgets/change_nav_button_type1.dart';
import 'package:smarter/app/modules/gym/home_module/widgets/change_nav_button_type2.dart';

class GymNavHome extends StatelessWidget {
  const GymNavHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
          child: Column(
            children: [
              ChangeNavButtonType1(
                navIndex: 1,
                backgroundColor: Color(0xFFF9DEDF),
                asset: 'assets/icon/manage_student.png',
                assetText: 'assets/icon/manage_student_txt.png',
                description: '원생, 승급, 출결관리 및 통계를 확인할 수 있습니다.',
              ),
              ChangeNavButtonType2(
                navIndex: 2,
                backgroundColor: Color(0xFFDCF0DE),
                asset: 'assets/icon/manage_payment.png',
                assetText: 'assets/icon/manage_payment_txt.png',
                description: '클래스 일정에 맞춰 자동으로 원비 청구, 수납 등 스마트하게 관리합니다.',
              ),
              ChangeNavButtonType1(
                navIndex: 3,
                backgroundColor: Color(0xFFEBDDF8),
                asset: 'assets/icon/manage_notification.png',
                assetText: 'assets/icon/manage_notification_txt.png',
                description: '도장과 원생, 부모님까지 소통할 수 있는 알림 게시판 공간입니다.',
              ),
              ChangeNavButtonType2(
                navIndex: 4,
                backgroundColor: Color(0xFFFAE0DC),
                asset: 'assets/icon/manage_schedule.png',
                assetText: 'assets/icon/manage_schedule_txt.png',
                description: '출결, 이벤트, 승급, 구매 등 다양한 스케줄 정보를 관리할 수 있습니다.',
              ),
              ChangeNavButtonType1(
                navIndex: 5,
                backgroundColor: Color(0xFFEBDDF8),
                asset: 'assets/icon/manage_my_page.png',
                assetText: 'assets/icon/manage_my_page_txt.png',
                description: '마이페이지에서 도장정보, 승급, 클래스를 쉽게 등록 관리합니다.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
