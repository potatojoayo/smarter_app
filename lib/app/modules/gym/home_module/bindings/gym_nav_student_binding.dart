import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_nav_student_controller.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/statistics_controller.dart';

class GymNavStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GymNavStudentController());
    Get.put(StatisticsController());
  }
}
