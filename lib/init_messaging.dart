import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/notification_module/controllers/notification_controller.dart';
import 'package:smarter/app/routes/routes.dart';

Future<void> initMessaging() async {
  if (Platform.isAndroid) {
    await FlutterNotificationChannel.registerNotificationChannel(
        description: '푸시알림채널',
        id: 'com.blocket.smarter',
        importance: NotificationImportance.IMPORTANCE_HIGH,
        name: '우리동대표 푸시알림채널',
        visibility: NotificationVisibility.VISIBILITY_PUBLIC,
        allowBubbles: true,
        enableSound: true,
        enableVibration: true,
        showBadge: true);
  }

  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    if (message.notification!.title == '회원가입 승인') {
      Get.offAllNamed(Routes.auth);
      return;
    } else if (message.notification!.title == '알림장') {
      Get.offAllNamed(Routes.gym, arguments: 3);
      return;
    } else if (message.notification!.title == '결석예정') {
      Get.offAllNamed(Routes.gym, arguments: 4);
      return;
    } else if (message.notification!.title == '무통장입금안내') {
      Get.offAllNamed(Routes.gym, arguments: 2);
      return;
    }
    Get.toNamed(Routes.notification);
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null && notification.title == '시안요청') {
      if (Get.routing.current != Routes.notification) {
        Get.toNamed(Routes.notification);
      }
    }
    await NotificationController.to.getCountNewNotifications();
  });
}
