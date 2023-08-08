import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_home_controller.dart';
import 'package:smarter/app/modules/gym/home_module/utils/build_bottom_navigation_bar_item.dart';

class GymBottomNavigationBar extends StatelessWidget {
  const GymBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        elevation: 0,
        currentIndex: GymHomeController.to.currentNavIndex,
        onTap: GymHomeController.to.changeNavIndex,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        items: [
          BottomNavigationBarItem(
            label: '홈',
            icon: const FaIcon(
              FontAwesomeIcons.house,
              color: Colors.grey,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.house,
              color: Get.theme.primaryColor,
            ),
          ),
          buildBottomNavigationBarItem(
              icon: 'assets/icon/nav_students.png',
              activeIcon: 'assets/icon/nav_active_students.png',
              navText: "원생관리"),
          buildBottomNavigationBarItem(
              icon: 'assets/icon/nav_payment.png',
              activeIcon: 'assets/icon/nav_active_payment.png',
              navText: "원비관리"),
          buildBottomNavigationBarItem(
              icon: 'assets/icon/nav_notification.png',
              activeIcon: 'assets/icon/nav_active_notification.png',
              navText: "알림장"),
          buildBottomNavigationBarItem(
              icon: 'assets/icon/nav_schedule.png',
              activeIcon: 'assets/icon/nav_active_schedule.png',
              navText: "스케쥴"),
          buildBottomNavigationBarItem(
              icon: 'assets/icon/nav_my_page.png',
              activeIcon: 'assets/icon/nav_active_my_page.png',
              navText: "마이페이지"),
        ],
      ),
    );
  }
}
