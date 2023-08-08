import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_home_controller.dart';

class GymHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GymHomeController());
  }
}
