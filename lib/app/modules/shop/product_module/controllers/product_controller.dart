import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/controllers/image_carousel_controller.dart';
import 'package:smarter/app/global/mixins/select_product_option_mixin.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/shop/cart_module/controllers/cart_controller.dart';
import 'package:smarter/app/modules/shop/product_module/product_mutation.dart';

class ProductController extends GetxController with SelectProductOptionMixin {
  static ProductController get to => Get.find();

  final userRequestController = TextEditingController();

  final _product = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get product => _product.value;

  int get draftIndex =>
      ProductController.to.logoImageCarouselController.currentCarouselIndex;

  final productImageCarouselController = ImageCarouselController();
  final logoImageCarouselController = ImageCarouselController();

  final _selectedDraft = Rx<Map<String, dynamic>?>(null);

  Map<String, dynamic>? get selectedDraft => _selectedDraft.value;

  set selectedDraft(value) => _selectedDraft.value = value;

  final _quantity = 0.obs;

  int get quantity => _quantity.value;

  set quantity(value) => _quantity.value = value;

  final quantityController = TextEditingController(text: '0');

  final studentNames = RxList<Map<String, dynamic>>([]);

  int get priceTotalProductDetail {
    int additionalPrice = selectedProductDetail!['priceAdditional'];
    int priceWork = 0;
    if (selectedDraft != null) {
      priceWork = selectedDraft!['priceWork'];
    }
    int priceProductDetail = product['priceGym'];
    return quantity * (additionalPrice + priceProductDetail + priceWork);
  }

  int get priceProducts {
    int additionalPrice = selectedProductDetail!['priceAdditional'];
    int priceProductDetail = product['priceGym'];
    return quantity * (additionalPrice + priceProductDetail);
  }

  int get priceTotalWork {
    var priceWork = 0;
    if (selectedDraft != null) {
      priceWork = selectedDraft!['priceWork'];
    }
    return quantity * priceWork;
  }

  final RxBool _useDraft = true.obs;

  bool get useDraft => _useDraft.value;

  set useDraft(value) => _useDraft.value = value;

  final RxBool _colorSelected = false.obs;

  bool get colorSelected => _colorSelected.value;

  set colorSelected(value) => _colorSelected.value = value;

  Future<void> requestDraft() async {
    final result = await Client().client.value.mutate(MutationOptions(
          document: gql(ProductMutation.createDraftRequest),
        ));
    final created = result.data!['createDraftRequest']['created'];
    if (!created) {
      showSnackBar('이미 시안을 요청하셨습니다. 관리자의 연락을 기다려주세요.');
    } else {
      showSnackBar('로고시안을 요청하셨습니다. 확인 후 연락 드리겠습니다.');
    }
  }

  void onPressedPurchaseButton() {
    if (selectedProductDetail == null) {
      showSnackBar('색상과 사이즈를 선택해주세요.');
      return;
    }
    {
      if (ProductController.to.quantity == 0) {
        showSnackBar('상품의 개수는 적어도 한개 이상으로 선택해주세요.');
        return;
      }

      CartController.to.addToCart(
        userRequest: userRequestController.text,
        priceTotalWork: priceTotalWork,
        priceProducts: priceProducts,
        productDetail: selectedProductDetail!,
        product: product,
        quantity: quantity,
        draft: selectedDraft,
      );
      quantity = 0;
      quantityController.text = '0';
      studentNames.assignAll([]);
      colorSelected = false;
      selectedColor = null;
      selectedDraft = null;
      selectedProductDetail = null;
    }
  }

  void setProductToController(productMaster) {
    _product.value = productMaster;
  }
}
