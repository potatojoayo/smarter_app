import 'package:get/get.dart';
import 'package:smarter/app/modules/auth_module/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}
