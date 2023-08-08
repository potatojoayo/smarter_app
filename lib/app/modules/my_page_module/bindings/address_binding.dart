import 'package:get/get.dart';
import 'package:smarter/app/modules/my_page_module/controllers/address_controller.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddressController());
  }
}
