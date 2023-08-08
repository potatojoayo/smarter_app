import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/utils/show_get_bottom_sheet.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/notification_module/controllers/notification_controller.dart';
import 'package:smarter/app/modules/shop/cart_module/controllers/cart_controller.dart';
import 'package:smarter/app/modules/shop/cart_module/widgets/cart_bottom_sheet.dart';
import 'package:smarter/app/routes/routes.dart';

final appBarActions = [
  Obx(
    () => Badge(
      badgeContent: Obx(
        () => DefaultText(
          CartController.to.cartedProducts.length.toString(),
          style: const TextStyle(color: backgroundColor, fontSize: 9),
          textAlign: TextAlign.center,
        ),
      ),
      position: BadgePosition.topEnd(top: 5, end: 5),
      showBadge: CartController.to.cartedProducts.isNotEmpty,
      badgeColor: Get.theme.colorScheme.error,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          showGetBottomSheet(
            bottomSheet: const CartBottomSheet(),
          );
          // Get.toNamed(Routes.speedOrder);
        },
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: FaIcon(
            FontAwesomeIcons.cartShopping,
            size: 20,
            color: textColor,
          ),
        ),
      ),
    ),
  ),
  Obx(
    () => Badge(
      badgeContent: Obx(
        () => DefaultText(
          NotificationController.to.countNewNotifications.toString(),
          style: TextStyle(color: Colors.grey[50], fontSize: 9),
          textAlign: TextAlign.center,
        ),
      ),
      position: BadgePosition.topEnd(top: 3, end: 3),
      showBadge: NotificationController.to.countNewNotifications > 0,
      badgeColor: Get.theme.colorScheme.error,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () async {
          await Get.toNamed(Routes.notification);
          NotificationController.to.readAll();
        },
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: FaIcon(
            FontAwesomeIcons.bell,
            color: textColor,
            size: 20,
          ),
        ),
      ),
    ),
  ),
  // Obx(
  //   () => Badge(
  //     badgeContent: Obx(
  //       () => DefaultText(
  //         CartController.to.cartedProducts.length.toString(),
  //         style: const TextStyle(color: backgroundColor, fontSize: 9),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //     position: BadgePosition.topEnd(top: 5, end: 5),
  //     showBadge: CartController.to.cartedProducts.isNotEmpty,
  //     badgeColor: Get.theme.colorScheme.error,
  //     child: InkWell(
  //       customBorder: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       onTap: () {
  //         showGetBottomSheet(
  //           bottomSheet: const CartBottomSheet(),
  //         );
  //       },
  //       child: const Padding(
  //         padding: EdgeInsets.all(10.0),
  //         child: FaIcon(
  //           FontAwesomeIcons.solidCartShopping,
  //           size: 20,
  //           color: textColor,
  //         ),
  //       ),
  //     ),
  //   ),
  // ),
  const SizedBox(
    width: 15,
  ),
];
