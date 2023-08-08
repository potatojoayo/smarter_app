import 'package:get/get.dart';
import 'package:smarter/app/modules/my_page_module/controllers/claim_controller.dart';

class ClaimBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClaimController());
  }
}
