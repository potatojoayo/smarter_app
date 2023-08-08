import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
  }
}
