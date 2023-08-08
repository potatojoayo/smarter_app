import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/gym_class_module/controllers/edit_class_controller.dart';

class EditClassBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditClassController());
  }
}
