import 'package:get/get.dart';
import 'package:smarter/app/modules/my_page_module/controllers/edit_my_info_controller.dart';

class EditMyInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditMyInfoController());
  }
}
