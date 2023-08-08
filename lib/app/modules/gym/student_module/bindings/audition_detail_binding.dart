import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/audition_detail_controller.dart';

class AuditionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuditionDetailController());
  }
}
