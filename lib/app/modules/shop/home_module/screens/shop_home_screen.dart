import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/app_bar_actions.dart';
import 'package:smarter/app/modules/shop/home_module/bindings/shop_nav_home_binding.dart';
import 'package:smarter/app/modules/shop/home_module/bindings/shop_nav_my_page_binding.dart';
import 'package:smarter/app/modules/shop/home_module/bindings/shop_nav_quick_order_binding.dart';
import 'package:smarter/app/modules/shop/home_module/bindings/shop_nav_shopping_binding.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_home_controller.dart';
import 'package:smarter/app/modules/shop/home_module/screens/shop_nav_home.dart';
import 'package:smarter/app/modules/shop/home_module/screens/shop_nav_my_page.dart';
import 'package:smarter/app/modules/shop/home_module/screens/shop_nav_quick_order.dart';
import 'package:smarter/app/modules/shop/home_module/screens/shop_nav_shopping.dart';
import 'package:smarter/app/modules/shop/home_module/widgets/home_bottom_nav_bar.dart';
import 'package:smarter/app/modules/shop/order_module/order_bindings/speed_order_binding.dart';
import 'package:smarter/app/modules/shop/order_module/screens/speed_order_screen.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:smarter/show_event_bottom_sheet.dart';

class ShopHomeScreen extends StatefulWidget {
  const ShopHomeScreen({Key? key}) : super(key: key);

  @override
  State<ShopHomeScreen> createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        showEventBottomSheet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (ShopHomeController.to.routingHistory.length < 3) {
          return false;
        }
        ShopHomeController.to.routingHistory.removeLast();
        final route = ShopHomeController.to.routingHistory.removeLast();
        Get.offNamed(route, id: 1);
        switch (route) {
          case Routes.shopHome:
            ShopHomeController.to.currentIndex.value = 0;
          case Routes.shopShopping:
            ShopHomeController.to.currentIndex.value = 1;
          // case Routes.shopSpeedOrder:
          //   ShopHomeController.to.currentIndex.value = 2;
          case Routes.shopQuickOrder:
            ShopHomeController.to.currentIndex.value = 2;
          case Routes.shopMyPage:
            ShopHomeController.to.currentIndex.value = 3;
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/icon/v2_logo.png',
            width: 120,
          ),
          titleTextStyle: const TextStyle(fontSize: 24),
          actions: appBarActions,
          leading: Obx(
            () => ShopHomeController.to.currentIndex.value == 0
                ? IconButton(
                    icon: SizedBox(
                      height: 50,
                      child: Image.asset('assets/icon/v2_school.png'),
                    ),
                    onPressed: () {
                      Get.offAndToNamed(Routes.gym);
                    },
                  )
                : const SizedBox.shrink(),
          ),
          titleSpacing: 0,
        ),
        body: Navigator(
          initialRoute: Routes.shopHome,
          key: Get.nestedKey(1),
          onGenerateRoute: (settings) {
            Get.routing.args = settings.arguments;

            GetPageRoute route = GetPageRoute(
              routeName: Routes.shopHome,
              page: () => const ShopNavHome(),
              binding: ShopNavHomeBinding(),
              transition: Transition.noTransition,
            );

            switch (settings.name) {
              case Routes.shopHome:
                ShopHomeController.to.currentIndex.value = 0;
                route = GetPageRoute(
                  routeName: Routes.shopHome,
                  page: () => const ShopNavHome(),
                  binding: ShopNavHomeBinding(),
                  transition: Transition.noTransition,
                );
              case Routes.shopShopping:
                ShopHomeController.to.currentIndex.value = 1;
                route = GetPageRoute(
                  routeName: Routes.shopShopping,
                  page: () => const ShopNavShopping(),
                  binding: ShopNavShoppingBinding(),
                  transition: Transition.noTransition,
                );
              // Get.removeRoute(route, id: 1);
              // case Routes.shopSpeedOrder:
              //   ShopHomeController.to.currentIndex.value = 2;
              //   route = GetPageRoute(
              //     routeName: Routes.shopSpeedOrder,
              //     page: () => const SpeedOrderScreen(),
              //     binding: SpeedOrderBinding(),
              //     transition: Transition.noTransition,
              //   );
              case Routes.shopQuickOrder:
                ShopHomeController.to.currentIndex.value = 2;
                route = GetPageRoute(
                  routeName: Routes.shopQuickOrder,
                  page: () => const ShopNavQuickOrder(),
                  binding: ShopNavQuickOrderBinding(),
                  transition: Transition.noTransition,
                );
              case Routes.shopMyPage:
                ShopHomeController.to.currentIndex.value = 3;
                route = GetPageRoute(
                  routeName: Routes.shopMyPage,
                  page: () => const ShopNavMyPage(),
                  binding: ShopNavMyPageBinding(),
                  transition: Transition.noTransition,
                );
            }

            ShopHomeController.to.routingHistory.add(route.routeName!);

            return route;
          },
        ),
        bottomNavigationBar: const HomeBottomNavBar(),
      ),
    );
  }
}
