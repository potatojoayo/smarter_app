import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/level_module/controllers/edit_level_controller.dart';

class EditLevelBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditLevelController());
  }
}
