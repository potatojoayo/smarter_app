import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShopHomeController(), permanent: true);
  }
}
