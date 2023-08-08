import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/smarter_money_module/controllers/charge_controller.dart';

class ChargeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChargeController());
  }
}
