import 'package:get/get.dart';

class ShopHomeController extends GetxController {
  static ShopHomeController get to => Get.find();

  final List<String> routingHistory = [];

  final currentIndex = 0.obs;
}
