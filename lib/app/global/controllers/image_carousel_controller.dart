import 'package:get/get.dart';

class ImageCarouselController extends GetxController {
  final RxInt _currentCarouselIndex = 0.obs;

  int get currentCarouselIndex => _currentCarouselIndex.value;

  set currentCarouselIndex(value) => _currentCarouselIndex.value = value;
}
