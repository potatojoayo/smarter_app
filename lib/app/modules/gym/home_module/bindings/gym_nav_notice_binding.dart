import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_nav_notice_controller.dart';

class GymNavNoticeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GymNavNoticeController());
  }
}
