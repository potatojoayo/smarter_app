import 'package:get/get.dart';

mixin SelectProductOptionMixin on GetxController {
  final _selectedProductDetail = Rx<Map<String, dynamic>?>(null);

  Map<String, dynamic>? get selectedProductDetail =>
      _selectedProductDetail.value;

  set selectedProductDetail(value) => _selectedProductDetail.value = value;

  final _selectedColor = Rx<String?>(null);

  String? get selectedColor => _selectedColor.value;

  set selectedColor(value) => _selectedColor.value = value;

  final RxList<Map<String, dynamic>> productDetailsOfSelectedColor =
      <Map<String, dynamic>>[].obs;
}
