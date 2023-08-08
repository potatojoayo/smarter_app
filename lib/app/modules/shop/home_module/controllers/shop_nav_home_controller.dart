import 'package:get/get.dart';
import 'package:smarter/app/global/controllers/image_carousel_controller.dart';

class ShopNavHomeController extends GetxController {
  static ShopNavHomeController get to => Get.find();

  final noticeCarouselController = ImageCarouselController();
  final bannerCarouselController = ImageCarouselController();

  getCategoryImage(String categoryName) {
    String basePath = 'assets/icon/category/';
    if (categoryName == '도복') {
      return '${basePath}dobok.png';
    } else if (categoryName == '벨트') {
      return '${basePath}belt.png';
    } else if (categoryName == '동복') {
      return '${basePath}dongbok.png';
    } else if (categoryName == '아웃터') {
      return '${basePath}outer.png';
    } else if (categoryName == '티셔츠') {
      return '${basePath}t_shirt.png';
    } else if (categoryName == '트레이닝복') {
      return '${basePath}sports_wear.png';
    } else if (categoryName == '신발') {
      return '${basePath}shoes.png';
    } else if (categoryName == '가방') {
      return '${basePath}bag.png';
    } else if (categoryName == '보호용품') {
      return '${basePath}boho_goods.png';
    } else if (categoryName == '격파용품') {
      return '${basePath}strike_goods.png';
    } else if (categoryName == '수련장비') {
      return '${basePath}training_goods.png';
    } else if (categoryName == '도장용품') {
      return '${basePath}gym_goods.png';
    } else if (categoryName == '병장기') {
      return '${basePath}weaponry.png';
    } else if (categoryName == '트로피,메달,상장') {
      return '${basePath}trophy_medal_crape.png';
    } else if (categoryName == '장식용품') {
      return '${basePath}decoration.png';
    } else if (categoryName == '마킹비') {
      return '${basePath}marking.png';
    }
    return '';
  }
}
