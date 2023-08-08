import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/class_payment_module/controllers/class_payment_detail_controller.dart';

class ClassPaymentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClassPaymentDetailController());
  }
}
