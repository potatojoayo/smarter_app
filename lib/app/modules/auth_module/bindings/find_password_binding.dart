import 'package:get/get.dart';
import 'package:smarter/app/modules/auth_module/controllers/find_password_controller.dart';

class FindPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FindPasswordController());
  }
}
