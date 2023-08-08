import 'package:get/get.dart';
import 'package:smarter/app/global/controllers/edit_delivery_address_controller.dart';

class EditDeliveryAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditDeliveryAddressController());
  }
}
