import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/notification_module/controllers/notification_controller.dart';
import 'package:smarter/app/routes/routes.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final Map<String, dynamic> notification;

  @override
  Widget build(BuildContext context) {
    Widget extraInfo = const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () async {
          NotificationController.to.readAll();
          NotificationController.to.getCountNewNotifications();
          if (notification['route'] != null) {
            if (notification['route'] == '/home') {
              return Get.until((route) => route.settings.name == Routes.shop);
            }
            if (notification['route'].toString().contains('/order/')) {
              Get.toNamed(notification['route']);
            } else {
              Get.offNamedUntil(notification['route'],
                  (route) => route.settings.name == Routes.shop);
            }
          }
          if (notification['title'] == '쿠폰발급') {
            Get.toNamed(Routes.myCoupons);
          }
          if (notification['notificationType'] == '결석예정 알림') {
            if (Get.routing.previous.contains('/shop')) {
              Get.offAllNamed(Routes.gym,
                  arguments: {'initialRoute': Routes.gymCalendar});
            } else {
              Get.back();
              Get.toNamed(Routes.gymCalendar, id: 2);
            }
          }
        },
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
              color: notification['dateRead'] == null
                  ? Colors.red[50]
                  : backgroundColor,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, offset: Offset(2, 2), blurRadius: 8)
              ],
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        notification['notificationType'],
                        style: TextStyle(
                            color: NotificationController.to
                                .getNotificationTitleColor(
                                    notification['notificationType']),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultText(
                        notification['contents'],
                        overflow: TextOverflow.visible,
                        style: Get.textTheme.labelLarge,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      extraInfo,
                      DefaultText(
                        timeago.format(
                            DateTime.parse(notification['dateCreated']),
                            locale: 'ko'),
                        style: Get.textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
