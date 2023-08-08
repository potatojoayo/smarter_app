import 'package:get/get.dart';
import 'package:smarter/app/modules/my_page_module/controllers/return_controller.dart';

class ReturnBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ReturnController());
  }
}
