import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_controller.dart';

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AttendanceController());
  }
}
