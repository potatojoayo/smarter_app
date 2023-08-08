import 'package:get/get.dart';

mixin CarouselMixin on GetxController {
  final RxInt _currentCarouselIndex = 0.obs;

  int get currentCarouselIndex => _currentCarouselIndex.value;

  set currentCarouselIndex(value) => _currentCarouselIndex.value = value;
}
