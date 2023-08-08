import 'package:get/get.dart';
import 'package:smarter/app/modules/my_page_module/controllers/nav_my_page_controller.dart';

class ShopNavMyPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavMyPageController());
  }
}
