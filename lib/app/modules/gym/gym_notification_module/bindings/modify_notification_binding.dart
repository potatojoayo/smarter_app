import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/controllers/modify_notification_controller.dart';

class ModifyNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ModifyNotificationController());
  }
}
