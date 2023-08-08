import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/shop/cart_module/controllers/cart_controller.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_controller.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/speed_order/speed_order_item.dart';

class SpeedOrderController extends GetxController {
  static SpeedOrderController get to => Get.find();

  final speedOrderItemWidgetList = <SpeedOrderItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    addOrderWidget();
  }

  void addOrderWidget() {
    speedOrderItemWidgetList.add(SpeedOrderItem(
      key: UniqueKey(),
      controller: SpeedOrderItemController(),
      parentController: this,
    ));
  }

  void addToCart() {
    final orderingProducts = <Map<String, dynamic>>[];
    for (var speedOrderItemWidget in speedOrderItemWidgetList) {
      final controller = speedOrderItemWidget.controller;
      if (controller.useDraft && controller.selectedDraft == null) {
        orderingProducts.clear();
        return showSnackBar(
            '등록된 로고가 없어 후작업이 불가합니다. 오프라인으로 문의를 주시거나 로고시안 등록요청 아이콘을 눌러 신청하시면 관리자가 연락 드립니다.',
            duration: 7000);
      }
      if (controller.orderingProducts.isEmpty) {
        return showSnackBar('장바구니에 담으실 상품을 모두 선택해주세요.');
      }
      for (Map<String, dynamic> product in controller.orderingProducts) {
        if (controller.useName) {
          for (var nameOption in controller.nameOptionList) {
            if (product['productDetail']['id'] ==
                nameOption.optionController.selectedProduct.value!['id']) {
              product['userRequest'] =
                  nameOption.optionController.userRequest.text;
            }
          }
        } else {
          product['userRequest'] = controller.userRequest.text;
        }
        orderingProducts.add(product);
      }
    }
    speedOrderItemWidgetList.clear();
    speedOrderItemWidgetList.add(
      SpeedOrderItem(
        key: UniqueKey(),
        controller: SpeedOrderItemController(),
        parentController: this,
      ),
    );
    CartController.to.addToCartAll(orderingProducts);
  }

  void removeSpeedOrderItemWidget(SpeedOrderItemController controller) {
    speedOrderItemWidgetList.removeWhere((w) => w.controller == controller);
  }
}
