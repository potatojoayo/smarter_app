import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/statistics_controller.dart';

class StatisticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StatisticsController());
  }
}
