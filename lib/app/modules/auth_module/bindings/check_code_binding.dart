import 'package:get/get.dart';
import 'package:smarter/app/modules/auth_module/controllers/check_code_controller.dart';

class CheckCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckCodeController());
  }
}
