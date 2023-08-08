import 'package:get/get.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_nav_student_controller.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_controller.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';

class SpeedOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SpeedOrderController());
    Get.put(ProductController());
    Get.put(GymNavStudentController());
  }
}
