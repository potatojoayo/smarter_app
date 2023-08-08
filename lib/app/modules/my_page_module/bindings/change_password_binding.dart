import 'package:get/get.dart';
import 'package:smarter/app/modules/my_page_module/controllers/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChangePasswordController());
  }
}
