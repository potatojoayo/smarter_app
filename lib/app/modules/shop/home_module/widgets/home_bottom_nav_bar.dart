import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_home_controller.dart';
import 'package:smarter/app/routes/routes.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: ShopHomeController.to.currentIndex.value,
        selectedItemColor: Get.theme.primaryColorDark,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) async {
          if (ShopHomeController.to.currentIndex.value == index) {
            return;
          }
          ShopHomeController.to.currentIndex.value = index;
          String route = Routes.shopHome;
          switch (index) {
            case 0:
              route = Routes.shopHome;
            case 1:
              route = Routes.shopShopping;
            // case 2:
            //   route = Routes.shopSpeedOrder;
            case 2:
              route = Routes.shopQuickOrder;
            case 3:
              route = Routes.shopMyPage;
          }

          await Get.offNamed(route, id: 1);
        },
        items: [
          BottomNavigationBarItem(
            label: '홈',
            icon: const FaIcon(
              FontAwesomeIcons.house,
              color: Colors.grey,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.solidHouse,
              color: Get.theme.primaryColorDark,
            ),
          ),
          BottomNavigationBarItem(
            label: '일반주문',
            icon: const FaIcon(
              FontAwesomeIcons.bagShopping,
              color: Colors.grey,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.solidBagShopping,
              color: Get.theme.primaryColorDark,
            ),
          ),
          // BottomNavigationBarItem(
          //   label: '스피드주문',
          //   icon: const FaIcon(
          //     FontAwesomeIcons.bolt,
          //     color: Colors.grey,
          //   ),
          //   activeIcon: FaIcon(
          //     FontAwesomeIcons.solidBolt,
          //     color: Get.theme.primaryColorDark,
          //   ),
          // ),
          BottomNavigationBarItem(
            label: '간편주문',
            icon: const FaIcon(
              FontAwesomeIcons.cartShoppingFast,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.solidCartShoppingFast,
              color: Get.theme.primaryColorDark,
            ),
          ),
          BottomNavigationBarItem(
            label: '마이페이지',
            icon: const FaIcon(
              FontAwesomeIcons.user,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.solidUser,
              color: Get.theme.primaryColorDark,
            ),
          ),
        ],
      ),
    );
  }
}
