import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_controller.dart';

class SpeedOrderItemOptionController extends GetxController {
  final selectedProduct = Rx<Map<String, dynamic>?>(null);
  final studentNames = <Map<String, dynamic>>[].obs;
  final _quantity = 0.obs;
  final userRequest = TextEditingController();

  final SpeedOrderItemController itemController;

  SpeedOrderItemOptionController({required this.itemController});

  int get quantity => _quantity.value;

  set quantity(value) {
    final previousQuantity = _quantity.value;
    _quantity.value = value;
    if (previousQuantity == 0 && value == 1) {
      _addOrderingProduct();
    } else if (previousQuantity == 1 && value == 0) {
      _removeOrderingProduct();
    } else {
      _changeOrderingProductQuantity();
    }
  }

  final quantityController = TextEditingController();

  void _addOrderingProduct() {
    itemController.orderingProducts.add({
      'priceTotalWork': itemController.selectedDraft != null
          ? itemController.selectedDraft!.priceWork!
          : 0,
      'priceProducts': (itemController.selectedProductMaster['priceGym'] +
          selectedProduct.value!['priceAdditional']),
      'productDetail': selectedProduct.value,
      'product': itemController.selectedProductMaster,
      'studentNames': studentNames,
      'quantity': quantity,
      'draft': itemController.selectedDraft?.toJson()
    });
  }

  void addStudent(Map<String, dynamic> student) {
    studentNames.add({'name': student['name'], 'count': 1.obs});
    quantity += 1;
    quantityController.text = quantity.toString();
  }

  void removeStudent(Map<String, dynamic> student) {
    studentNames.removeWhere((s) => s['name'] == student['name']);
    quantity -= 1;
    quantityController.text = quantity.toString();
  }

  void _changeOrderingProductQuantity() {
    final orderingProduct = itemController.orderingProducts.firstWhere(
        (p) => p['productDetail']['id'] == selectedProduct.value!['id']);
    orderingProduct['quantity'] = quantity;
    orderingProduct['priceTotalWork'] = itemController.selectedDraft != null
        ? itemController.selectedDraft!.priceWork! * quantity
        : 0;
    orderingProduct['priceProducts'] = quantity *
        (itemController.selectedProductMaster['priceGym'] +
            selectedProduct.value!['priceAdditional']);
    orderingProduct['studentNames'] = studentNames;
  }

  void _removeOrderingProduct() {
    itemController.orderingProducts.removeWhere((product) =>
        product['productDetail']['id'] == selectedProduct.value!['id']);
  }

  RxBool isChecked(String studentName) {
    return (studentNames.firstWhereOrNull((s) => s['name'] == studentName) !=
            null)
        .obs;
  }
}
