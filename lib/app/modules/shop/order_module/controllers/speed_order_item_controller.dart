import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/artemis_client.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/global/controllers/image_carousel_controller.dart';
import 'package:smarter/app/global/utils/show_snack_bar.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_option_controller.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/speed_order/select_name_option.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/speed_order/speed_order_option_item.dart';
import 'package:smarter/app/modules/shop/product_module/product_mutation.dart';
import 'package:smarter/app/modules/shop/product_module/product_query.dart';
import 'package:smarter/graphql_api.dart';

class SpeedOrderItemController extends GetxController {
  static SpeedOrderItemController get to => Get.find();

  final nameOptionList = <SelectNameOption>[].obs;

  final userRequest = TextEditingController();

  final _useDraft = false.obs;

  get useDraft => _useDraft.value;

  set useDraft(value) {
    if (value) {
      if (selectedCategory != null && selectedSubCategory != null) {
        _getDraftList().then((_) {
          for (Map<String, dynamic> orderingProduct in orderingProducts) {
            orderingProduct['draft'] = selectedDraft?.toJson();
          }
        });
      }
    } else {
      selectedDraft = null;
      draftList.clear();
      nameOptionList.clear();
      if (!useName) {
        for (Map<String, dynamic> orderingProduct in orderingProducts) {
          orderingProduct['draft'] = null;
        }
      }
    }
    _useDraft.value = value;
  }

  final _useName = false.obs;

  get useName => _useName.value;

  set useName(value) {
    nameOptionList.clear();
    productListOfSelectedColor.value = {};
    productMasterList.value = [];
    selectedProductMaster = null;
    selectedProductMasterName = null;
    brandList.value = [];
    selectedBrand = null;
    selectedSubCategory = null;
    _selectedCategory.value = null;
    _useName.value = value;
  }

  final _selectedCategory = Rx<String?>(null);

  get selectedCategory => _selectedCategory.value;

  set selectedCategory(value) {
    selectedDraft = null;
    draftList.clear();
    nameOptionList.clear();
    productListOfSelectedColor.value = {};
    productMasterList.value = [];
    selectedProductMaster = null;
    selectedProductMasterName = null;
    brandList.value = [];
    selectedBrand = null;
    selectedSubCategory = null;
    _selectedCategory.value = value;
  }

  final categoryList = <Map<String, dynamic>>[];

  final _selectedSubCategory = Rx<String?>(null);

  get selectedSubCategory => _selectedSubCategory.value;

  set selectedSubCategory(value) {
    selectedDraft = null;
    draftList.clear();
    nameOptionList.clear();
    productListOfSelectedColor.value = {};
    productMasterList.value = [];
    selectedProductMaster = null;
    selectedProductMasterName = null;
    brandList.value = [];
    selectedBrand = null;
    _selectedSubCategory.value = value;
    if (value != null) {
      Client()
          .client
          .value
          .query(
            QueryOptions(
              document: gql(ProductQuery.brandList),
              fetchPolicy: FetchPolicy.cacheAndNetwork,
              variables: {'subCategory': selectedSubCategory},
            ),
          )
          .then((result) {
        brandList.assignAll(List<String>.from(result.data!['brandList']));
      });
    }
  }

  final RxList<String> brandList = <String>[].obs;
  final productMasterList = <Map<String, dynamic>>[].obs;

  final _selectedBrand = Rx<String?>(null);

  get selectedBrand => _selectedBrand.value;

  set selectedBrand(value) {
    nameOptionList.clear();
    productListOfSelectedColor.value = {};
    productMasterList.value = [];
    selectedProductMaster = null;
    selectedProductMasterName = null;
    _selectedBrand.value = value;

    if (selectedBrand != null) {
      Client()
          .client
          .value
          .query(
            QueryOptions(
              document: gql(ProductQuery.productMasters),
              fetchPolicy: FetchPolicy.networkOnly,
              variables: {
                'category': selectedCategory,
                'subCategory': selectedSubCategory,
                'brand': selectedBrand
              },
            ),
          )
          .then((result) {
        productMasterList.assignAll(List<Map<String, dynamic>>.from(result
            .data!['productMasters']['edges']
            .map((product) => product['node'])));
      });
    }
  }

  final _selectedProductMasterName = Rx<String?>(null);

  get selectedProductMasterName => _selectedProductMasterName.value;

  set selectedProductMasterName(value) {
    nameOptionList.clear();
    productListOfSelectedColor.value = {};
    _selectedProductMasterName.value = value;
    if (value != null) {
      selectedProductMaster = productMasterList
          .firstWhere((productMaster) => productMaster['name'] == value);
      if (selectedProductMaster['colors'].length == 1) {
        selectColorOption(selectedProductMaster['colors'][0]);
      }

      if (useDraft && selectedCategory != null && selectedSubCategory != null) {
        _getDraftList();
      }
    }
  }

  final _selectedProductMaster = Rx<Map<String, dynamic>?>(null);

  get selectedProductMaster => _selectedProductMaster.value;

  set selectedProductMaster(value) => _selectedProductMaster.value = value;

  List<String> get productMasterNameList {
    if (productMasterList.isNotEmpty) {
      return List<String>.from(
          productMasterList.map((productMaster) => productMaster['name']));
    }
    return [];
  }

  RxList<String> get productMasterColorOptionList {
    if (_selectedProductMaster.value != null) {
      return List<String>.from(_selectedProductMaster.value!['colors']).obs;
    }
    return <String>[].obs;
  }

  RxList<Map<String, dynamic>> selectedProductList =
      <Map<String, dynamic>>[].obs;

  final productListOfSelectedColor = <String, dynamic>{}.obs;

  final _selectedDraft = Rx<MyDrafts$Query$NewDraftType?>(null);

  MyDrafts$Query$NewDraftType? get selectedDraft => _selectedDraft.value;

  set selectedDraft(MyDrafts$Query$NewDraftType? value) =>
      _selectedDraft.value = value;

  final draftList = RxList<MyDrafts$Query$NewDraftType>([]);

  final productImageCarouselController = ImageCarouselController();
  final logoImageCarouselController = ImageCarouselController();

  int get draftIndex => logoImageCarouselController.currentCarouselIndex;

  Future<void> _getDraftList() async {
    final client = Artemis().client;
    final response = await client.execute(MyDraftsQuery(
        variables: MyDraftsArguments(subCategoryName: selectedSubCategory)));
    if (response.hasErrors) {
      return;
    }
    draftList.clear();
    for (MyDrafts$Query$NewDraftType? draft in response.data!.myDrafts!) {
      draftList.add(draft!);
    }
    if (draftList.isNotEmpty) {
      selectedDraft = draftList[0];
    }
  }

  void selectDraft(int index) {
    selectedDraft = draftList[index];
  }

  final orderOptionWidgetList = <SpeedOrderOptionItem>[].obs;

  final optionWidgetListOfEachColor = <Map<String, dynamic>>[].obs;

  final List<Map<String, dynamic>> orderingProducts = [];

  final productListOfEachColor = <Map<String, dynamic>>[].obs;

  void addProduct(Map<String, dynamic> product) {
    orderingProducts.add({
      'priceTotalWork': selectedDraft != null
          ? selectedDraft!.priceWork! * product['quantity']
          : 0,
      'priceProducts': product['quantity'] *
          (selectedProductMaster['priceGym'] + product['priceAdditional']),
      'productDetail': product,
      'product': selectedProductMaster,
      'quantity': product['quantity'],
      'draft': selectedDraft?.toJson()
    });
  }

  void changeOrderingProductQuantity(Map<String, dynamic> product) {
    final orderingProduct = orderingProducts
        .firstWhere((p) => p['productDetail']['id'] == product['id']);
    orderingProduct['quantity'] = product['quantity'];
    orderingProduct['priceTotalWork'] = selectedDraft != null
        ? selectedDraft!.priceWork! * product['quantity']
        : 0;
    orderingProduct['priceProducts'] = product['quantity'] *
        (selectedProductMaster['priceGym'] + product['priceAdditional']);
  }

  void removeOrderingProduct(Map<String, dynamic> product) {
    orderingProducts.removeWhere(
        (product) => product['productDetail']['id'] == product['id']);
  }

  void refreshUseName() {
    _useName.refresh();
  }

  List<String> get subCategoryList {
    try {
      final category = categoryList
          .firstWhere((element) => element['name'] == selectedCategory);
      return List<String>.from(category['children'].map((c) => c['name']));
    } catch (e) {
      return [];
    }
  }

  void selectColorOption(String color) {
    if (productListOfSelectedColor.containsKey(color)) {
      productListOfSelectedColor.remove(color);
    } else {
      final productList = List<Map<String, dynamic>>.from(
          selectedProductMaster['products']
              .where((product) => product['color'] == color));

      productListOfSelectedColor[color] = productList;
    }
  }

  selectColorOptionInName(String color) {
    final productList = List<Map<String, dynamic>>.from(
        selectedProductMaster['products']
            .where((product) => product['color'] == color));
    return productList;
  }

  RxBool isSelectedColor(String color) {
    return productListOfSelectedColor.containsKey(color).obs;
  }

  void addNameOption() {
    nameOptionList.add(SelectNameOption(
      key: UniqueKey(),
      controller: this,
      optionController: SpeedOrderItemOptionController(itemController: this),
    ));
  }

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

  void removeNameOption(SpeedOrderItemOptionController controller) {
    if (controller.selectedProduct.value != null) {
      orderingProducts.removeWhere((p) =>
          p['productDetail']['id'] == controller.selectedProduct.value!['id']);
    }
    nameOptionList.removeWhere((no) => no.optionController == controller);
  }
}
