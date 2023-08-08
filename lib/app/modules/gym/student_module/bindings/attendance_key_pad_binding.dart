import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/attendance_key_pad_controller.dart';

class AttendanceKeyPadBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AttendanceKeyPadController());
  }
}
