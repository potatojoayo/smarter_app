import 'package:get/get.dart';
import 'package:smarter/app/modules/auth_module/controllers/new_password_controller.dart';

class NewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NewPasswordController());
  }
}
