import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/order_controller.dart';
import 'package:smarter/app/modules/shop/smarter_money_module/controllers/smarter_money_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SmarterMoneyController());
    Get.put(OrderController());
  }
}
