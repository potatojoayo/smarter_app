import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_home_controller.dart';
import 'package:smarter/app/modules/notification_module/controllers/notification_controller.dart';
import 'package:smarter/app/routes/routes.dart';

class GymHomeAppBar extends StatelessWidget {
  const GymHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Obx(() => GymHomeController.to.currentNavTitleWidget),
      actions: [
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () => Get.toNamed(Routes.attendanceKeyPad),
            child: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset(
                  'assets/icon/keypad_icon.png',
                )),
          ),
        ),
        Obx(
          () => badge.Badge(
            badgeContent: Obx(
              () => DefaultText(
                NotificationController.to.countNewNotifications.toString(),
                style: TextStyle(color: Colors.grey[50], fontSize: 9),
                textAlign: TextAlign.center,
              ),
            ),
            position: badge.BadgePosition.topEnd(top: 2, end: 2),
            showBadge: NotificationController.to.countNewNotifications > 0,
            badgeColor: Get.theme.colorScheme.error,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () => Get.toNamed(Routes.notification),
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
        const SizedBox(
          width: 15,
        ),
      ],
      leading: Obx(() => GymHomeController.to.currentNavLeading),
    );
  }
}
