import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/class_payment_module/controllers/class_payment_controller.dart';
import 'package:smarter/app/modules/gym/class_payment_module/controllers/class_payment_controller2.dart';
import 'package:smarter/app/modules/gym/student_module/controllers/statistics_controller.dart';

class GymNavFeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClassPaymentController());
    Get.put(ClassPaymentController2());
    Get.put(StatisticsController());
  }
}
