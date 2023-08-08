import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_shopping_controller.dart';

class ShopNavShoppingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShopNavShoppingController());
  }
}
