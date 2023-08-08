import 'package:get/get.dart';
import 'package:smarter/app/modules/notification_module/controllers/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}
