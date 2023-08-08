import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/controllers/create_notification_controller.dart';

class CreateNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateNotificationController());
  }
}
