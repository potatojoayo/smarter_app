import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/calendar_controller.dart';

class GymNavCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CalendarController());
  }
}
