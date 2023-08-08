import 'package:get/get.dart';
import 'package:smarter/app/modules/notification_module/controllers/notification_controller.dart';
import 'package:smarter/app/modules/shop/cart_module/controllers/cart_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
    Get.put(CartController());
  }
}
