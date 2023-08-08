import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/edit_student_controller.dart';

class EditStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditStudentController());
  }
}
