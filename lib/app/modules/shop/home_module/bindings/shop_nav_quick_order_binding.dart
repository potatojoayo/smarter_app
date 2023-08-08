import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_quick_order_controller.dart';

class ShopNavQuickOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShopNavQuickOrderController());
  }
}
