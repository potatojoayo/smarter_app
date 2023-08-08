import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/audition_master_controller.dart';

class AuditionMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuditionMasterController());
  }
}
