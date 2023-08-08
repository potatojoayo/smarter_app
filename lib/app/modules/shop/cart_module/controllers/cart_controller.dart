import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/shop/order_module/order_mutation.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';
import 'package:smarter/app/routes/routes.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();
  final RxList<Map<String, dynamic>> cartedProducts =
      <Map<String, dynamic>>[].obs;

  int get checkedCount =>
      cartedProducts.where((c) => c['checked'].value == true).length;

  int get totalCount => cartedProducts.length;

  final RxBool isPickUp = false.obs;

  List<Map<String, dynamic>> get checkedProducts {
    return List<Map<String, dynamic>>.from(
        cartedProducts.where((p) => p['checked'].value));
  }

  int get priceAllProducts => cartedProducts.fold(0, (a, b) {
        if (b['checked'].value) {
          return a + (b['priceProducts'] as int);
        } else {
          return a;
        }
      });

  int get priceAllWorks => cartedProducts.fold(0, (a, b) {
        if (b['checked'].value) {
          return a + (b['priceTotalWork'] as int);
        } else {
          return a;
        }
      });

  int get priceTotal => priceAllProducts + priceAllWorks;

  int get priceDelivery => cartedProducts.fold(
        0,
        (a, b) {
          if (b['checked'].value) {
            return max(a, b['product']['priceDelivery'] as int);
          } else {
            return a;
          }
        },
      );

  int get priceFinal => priceAllProducts + priceDelivery + priceAllWorks;

  void deleteChecked() {
    CartController.to.cartedProducts.assignAll(CartController.to.cartedProducts
        .where((c) => !c['checked'].value)
        .toList());
  }

  Future<void> order() async {
    final orderedProducts =
        List<Map<String, dynamic>>.from(checkedProducts.map((p) => {
              'productMasterId': p['product']['productMasterId'],
              'productId': p['productDetail']['id'],
              'quantity': p['quantity'],
              'draftId': p['draft'] != null ? p['draft']['id'] : null,
              'userRequest': p['userRequest'],
              'studentNames': p['studentNames'] != null
                  ? List<String>.from(p['studentNames'].map((n) => n['name']))
                  : []
            }));
    final result = await Client().client.value.mutate(
          MutationOptions(
            document: gql(OrderMutation.placeOrder),
            variables: {
              'orderedProducts': orderedProducts,
              'isPickUp': isPickUp.value,
            },
          ),
        );
    if (result.hasException) {
      return;
    }
    final orderMasterId = result.data!['placeOrder']['orderMaster']['id'];
    Get.toNamed('${Routes.order}/$orderMasterId');
  }

  void emptyCart() {
    CartController.to.cartedProducts.assignAll(CartController.to.cartedProducts
        .where((c) => !c['checked'].value)
        .toList());
  }

  void addToCart(
      {required Map<String, dynamic> product,
      required Map<String, dynamic> productDetail,
      required int quantity,
      required int priceProducts,
      required int priceTotalWork,
      required String userRequest,
      Map<String, dynamic>? draft}) {
    final studentNames =
        List<Map<String, dynamic>>.from(ProductController.to.studentNames);
    cartedProducts.add({
      'priceProducts': priceProducts,
      'priceTotalWork': priceTotalWork,
      'product': product,
      'productDetail': productDetail,
      'quantity': quantity,
      'userRequest': userRequest,
      'priceTotal': ProductController.to.priceTotalProductDetail,
      'studentNames': studentNames,
      'draft': draft,
      'checked': true.obs,
    });
    showSnackBar('선택하신 상품이 장바구니에 추가되었습니다.');
  }

  void addToCartAll(List<Map<String, dynamic>> orderingProducts) {
    // final studentNames =
    // List<Map<String, dynamic>>.from(ProductController.to.studentNames);
    //
    for (Map<String, dynamic> product in orderingProducts) {
      cartedProducts.add({
        'priceProducts': product['priceProducts'],
        'priceTotalWork': product['priceTotalWork'],
        'product': product['product'],
        'productDetail': product['productDetail'],
        'quantity': product['quantity'],
        'userRequest': product['userRequest'],
        'priceTotal': product['priceProducts'] + product['priceTotalWork'],
        'studentNames': product['studentNames'] ?? [],
        'draft': product['draft'],
        'checked': true.obs,
      });
    }

    Get.snackbar(
      '알림',
      '선택하신 상품이 장바구니에 추가되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(bottom: 60, left: 5, right: 5),
    );
  }

  void addToCartInSpeedOrder(
      {required Map<String, dynamic> product,
      required Map<String, dynamic> productDetail,
      required int quantity,
      required int priceProducts,
      required int priceTotalWork,
      required String userRequest,
      required List<Map<String, dynamic>> studentNames,
      required int priceTotal,
      Map<String, dynamic>? draft}) {
    cartedProducts.add({
      'priceProducts': priceProducts,
      'priceTotalWork': priceTotalWork,
      'product': product,
      'productDetail': productDetail,
      'quantity': quantity,
      'userRequest': userRequest,
      'priceTotal': priceTotal,
      'studentNames': studentNames,
      'draft': draft,
      'checked': true.obs,
    });
    // Get.snackbar(
    //   '알림',
    //   '선택하신 상품이 장바구니에 추가되었습니다.',
    //   snackPosition: SnackPosition.BOTTOM,
    //   margin: const EdgeInsets.only(bottom: 60, left: 5, right: 5),
    // );
  }
}
