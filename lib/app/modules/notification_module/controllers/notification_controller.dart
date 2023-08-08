import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/modules/auth_module/controllers/auth_controller.dart';
import 'package:smarter/app/modules/notification_module/notification_mutation.dart';
import 'package:smarter/app/modules/notification_module/notification_query.dart';
import 'package:smarter/init_messaging.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();

  final _countNewNotifications = 0.obs;

  int get countNewNotifications => _countNewNotifications.value;

  set countNewNotifications(value) => _countNewNotifications.value = value;

  Future<void> getCountNewNotifications() async {
    final result = await Client().client.value.query(
          QueryOptions(
            document: gql(NotificationQuery.countNewNotifications),
          ),
        );
    try {
      countNewNotifications = result.data!['countNewNotifications'];
    } catch (_) {}
  }

  Future<void> readAll() async {
    FlutterAppBadger.removeBadge();
    await Client().client.value.mutate(
          MutationOptions(
            document: gql(NotificationMutation.readNotifications),
          ),
        );
  }

  getNotificationTitleColor(String notificationType) {
    if (notificationType == '결석예정 알림') {
      return Colors.red;
    } else if (notificationType == '간편주문 결제요청') {
      return Get.theme.primaryColor;
    } else {
      return textLight;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (AuthController.to.user != null) {
      initMessaging();
    }
  }
}
