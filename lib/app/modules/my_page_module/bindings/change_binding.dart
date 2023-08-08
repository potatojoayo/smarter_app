import 'package:get/get.dart';
import 'package:smarter/app/modules/my_page_module/controllers/change_controller.dart';

class ChangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChangeController());
  }
}
