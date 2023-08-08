import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/audition_calendar_controller.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/create_audition_controller.dart';

class CreateAuditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateAuditionController());
    Get.put(AuditionCalendarController());
  }
}
