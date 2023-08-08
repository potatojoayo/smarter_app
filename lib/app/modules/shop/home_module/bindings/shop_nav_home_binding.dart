import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_home_controller.dart';

class ShopNavHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShopNavHomeController());
  }
}
