import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpeedOrderOptionController extends GetxController {
  static SpeedOrderOptionController get to => Get.find();

  final _selectedProductDetail = Rx<Map<String, dynamic>?>(null);
  Map<String, dynamic>? get selectedProductDetail =>
      _selectedProductDetail.value;
  set selectedProductDetail(value) => _selectedProductDetail.value = value;

  // final _selectedColorList = [].obs;
  // List get selectedColorList => _selectedColorList.value;
  // set selectedColorList(value) => _selectedColorList.value = value;

  final _selectedColor = Rx<String?>(null);
  String? get selectedColor => _selectedColor.value;
  set selectedColor(value) => _selectedColor.value = value;

  // final _studentList = <String>[].obs;
  // List get studentList => _studentList.value;
  // set studentList(value) => _studentList.value = value;

  final studentNames = RxList<Map<String, dynamic>>([]);

  final _selectedProductMaster = Rx({});
  get selectedProductMaster => _selectedProductMaster.value;
  set selectedProductMaster(value) => _selectedProductMaster.value = value;

  final quantityController = TextEditingController(text: '0');

  final _quantity = 0.obs;
  int get quantity => _quantity.value;
  set quantity(value) => _quantity.value = value;

  // final List<Map<String, dynamic>> orderingProducts = [];

  final RxList<Map<String, dynamic>> productDetailsOfSelectedColor =
      <Map<String, dynamic>>[].obs;

  final selectedCheckList = [].obs;

  final selectedColorCheckList = [].obs;

  final studentListController = TextEditingController();

  Function? fetchMoreStudents;

  final userRequestController = TextEditingController();

  void quantityRefresh() {
    _quantity.refresh();
  }

  int getPriceProducts(product) {
    int additionalPrice = selectedProductDetail!['priceAdditional'];
    int priceProductDetail = product['priceGym'];
    return quantity * (additionalPrice + priceProductDetail);
  }

  int getPriceTotalWork(selectedDraft) {
    var priceWork = 0;
    if (selectedDraft != null) {
      priceWork = selectedDraft!['priceWork'];
    }
    return quantity * priceWork;
  }
}
