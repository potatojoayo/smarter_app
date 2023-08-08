import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/kakao_floating_action_button.dart';
import 'package:smarter/app/modules/gym/home_module/bindings/gym_nav_calendar_binding.dart';
import 'package:smarter/app/modules/gym/home_module/bindings/gym_nav_fee_binding.dart';
import 'package:smarter/app/modules/gym/home_module/bindings/gym_nav_notice_binding.dart';
import 'package:smarter/app/modules/gym/home_module/bindings/gym_nav_student_binding.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_home_controller.dart';
import 'package:smarter/app/modules/gym/home_module/screens/gym_nav_calendar.dart';
import 'package:smarter/app/modules/gym/home_module/screens/gym_nav_fee.dart';
import 'package:smarter/app/modules/gym/home_module/screens/gym_nav_home.dart';
import 'package:smarter/app/modules/gym/home_module/screens/gym_nav_my_page.dart';
import 'package:smarter/app/modules/gym/home_module/screens/gym_nav_notice.dart';
import 'package:smarter/app/modules/gym/home_module/screens/gym_nav_student.dart';
import 'package:smarter/app/modules/gym/home_module/widgets/gym_home_app_bar.dart';
import 'package:smarter/app/modules/gym/home_module/widgets/gym_home_navigation_bar.dart';
import 'package:smarter/app/modules/shop/home_module/bindings/shop_nav_my_page_binding.dart';
import 'package:smarter/app/routes/routes.dart';

class GymHomeScreen extends StatelessWidget {
  const GymHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(id: 2);
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size(double.infinity, 56),
            child: GymHomeAppBar(),
          ),
          body: Navigator(
            key: Get.nestedKey(2),
            initialRoute:
                Get.arguments != null && Get.arguments['initialRoute'] != null
                    ? Get.arguments['initialRoute']
                    : Routes.gymHome,
            onGenerateRoute: (settings) {
              if (Get.arguments != null &&
                  Get.arguments['initialRoute'] != null) {
                final initialRoute = Get.arguments['initialRoute'];
                if (initialRoute == Routes.gymCalendar) {
                  GymHomeController.to.currentNavIndex = 4;
                }
              }
              Get.routing.args = settings.arguments;
              switch (settings.name) {
                case Routes.gymHome:
                  return GetPageRoute(
                    page: () => const GymNavHome(),
                    transition: Transition.noTransition,
                  );
                case Routes.gymStudent:
                  return GetPageRoute(
                    page: () => const GymNavStudent(),
                    binding: GymNavStudentBinding(),
                    transition: Transition.noTransition,
                  );
                case Routes.gymFee:
                  return GetPageRoute(
                    page: () => const GymNavFee(),
                    binding: GymNavFeeBinding(),
                    transition: Transition.noTransition,
                  );
                case Routes.gymNotice:
                  return GetPageRoute(
                    page: () => const GymNavNotice(),
                    binding: GymNavNoticeBinding(),
                    transition: Transition.noTransition,
                  );
                case Routes.gymCalendar:
                  GymHomeController.to.currentNavIndex = 4;
                  return GetPageRoute(
                    page: () => const GymNavCalendar(),
                    binding: GymNavCalendarBinding(),
                    transition: Transition.noTransition,
                  );
                case Routes.gymMyPage:
                  return GetPageRoute(
                    page: () => const GymNavMyPage(),
                    binding: ShopNavMyPageBinding(),
                    transition: Transition.noTransition,
                  );
              }
              return null;
            },
          ),
          bottomNavigationBar: const GymBottomNavigationBar(),
          floatingActionButton: Obx(() =>
              GymHomeController.to.currentNavIndex == 5
                  ? const KakaoFloatingActionButton()
                  : Container()),
        ),
      ),
    );
  }
}
