import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_controller.dart';

class ShopNavSpeedOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SpeedOrderController());
  }
}
