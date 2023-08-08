import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/data/provider/client.dart';
import 'package:smarter/app/modules/shop/product_module/product_query.dart';

class ShopNavShoppingController extends GetxController {
  static ShopNavShoppingController get to => Get.find();
  final selectedCategory = Rx<String?>(null);
  final selectedSubCategory = Rx<String?>(null);
  final selectedBrand = Rx<String?>(null);
  final categoryList = <Map<String, dynamic>>[].obs;
  final brandList = <String>[].obs;
  final isLoading = true.obs;

  RxList<Map<String, dynamic>> get subCategoryList {
    final category = categoryList
        .firstWhereOrNull((c) => c['name'] == selectedCategory.value);
    if (category != null) {
      return List<Map<String, dynamic>>.from(category['children']).obs;
    } else {
      return <Map<String, dynamic>>[].obs;
    }
  }

  RxBool isSelectedCategory(Map<String, dynamic> category) {
    return (ShopNavShoppingController.to.selectedCategory.value ==
            category['name'])
        .obs;
  }

  Future<void> changeCategory(Map<String, dynamic> category) async {
    isLoading.value = true;
    selectedCategory.value = category['name'];
    selectedSubCategory.value = category['children'][0]['name'];
    final brandListQueryResult = await Client().client.value.query(QueryOptions(
        document: gql(ProductQuery.brandList),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        variables: {'subCategory': selectedSubCategory.value}));
    brandList
        .assignAll(List<String>.from(brandListQueryResult.data!['brandList']));
    selectedBrand.value = brandList[0];
    isLoading.value = false;
  }

  Future<void> changeSubCategory(String subCategory) async {
    isLoading.value = true;
    selectedSubCategory.value = subCategory;
    final brandListQueryResult = await Client().client.value.query(QueryOptions(
        document: gql(ProductQuery.brandList),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        variables: {'subCategory': selectedSubCategory.value}));
    brandList
        .assignAll(List<String>.from(brandListQueryResult.data!['brandList']));
    selectedBrand.value = brandList[0];
    isLoading.value = false;
  }

  Future<void> changeBrand(String brand) async {
    isLoading.value = true;
    selectedBrand.value = brand;
    isLoading.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    final categoriesQueryResult =
        await Client().client.value.query(QueryOptions(
              document: gql(ProductQuery.categories),
              fetchPolicy: FetchPolicy.cacheAndNetwork,
            ));
    categoryList.assignAll(List<Map<String, dynamic>>.from(
        categoriesQueryResult.data!['categories']));
    final category =
        Get.arguments != null ? Get.arguments['category'] : categoryList[0];

    selectedCategory.value = category['name'];
    selectedSubCategory.value = category['children'][0]['name'];

    final brandListQueryResult = await Client().client.value.query(QueryOptions(
        document: gql(ProductQuery.brandList),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        variables: {'subCategory': selectedSubCategory.value}));
    brandList
        .assignAll(List<String>.from(brandListQueryResult.data!['brandList']));
    selectedBrand.value = brandList[0];
    isLoading.value = false;
  }
}
