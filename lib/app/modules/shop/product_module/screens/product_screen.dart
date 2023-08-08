import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smarter/app/global/widgets/default_app_bar.dart';
import 'package:smarter/app/global/widgets/image_carousel.dart';
import 'package:smarter/app/global/widgets/purchase_button.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';
import 'package:smarter/app/modules/shop/product_module/product_query.dart';
import 'package:smarter/app/modules/shop/product_module/widgets/product_info.dart';
import 'package:smarter/app/routes/routes.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          child: SizedBox(
            height: 50,
            child: PurchaseButton(
              onPressed: ProductController.to.onPressedPurchaseButton,
              iconData: FontAwesomeIcons.solidCartShopping,
              title: '장바구니 담기',
            ),
          ),
        ),
        body: Query(
          options: QueryOptions(
            document: gql(ProductQuery.productMasterNode),
            variables: {
              "id": Get.parameters['id'],
            },
          ),
          builder: (QueryResult<Object?> result,
              {Future<QueryResult<Object?>> Function(FetchMoreOptions)?
                  fetchMore,
              Future<QueryResult<Object?>?> Function()? refetch}) {
            if (result.isLoading) {
              return SpinKitChasingDots(
                color: Get.theme.primaryColorDark,
              );
            }

            Map<String, dynamic>? product = result.data?['productMasterNode'];

            if (product == null) {
              return const Text('none');
            } else {
              ProductController.to.setProductToController(product);
            }

            return CustomScrollView(
              slivers: [
                defaultAppBar(
                  title: '상품정보',
                  centerTitle: true,
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageCarousel(
                          aspectRatio: 1,
                          images: [
                            SizedBox(
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.fullScreenImage,
                                      arguments: {'url': product['thumbnail']});
                                },
                                child: Image.network(
                                  product['thumbnail'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            ...List<Widget>.from(
                              (product['imageUrls'].map(
                                (url) => SizedBox(
                                  width: double.infinity,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.fullScreenImage,
                                          arguments: {'url': url});
                                    },
                                    child: Image.network(
                                      url,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              )),
                            )
                          ],
                          controller: ProductController
                              .to.productImageCarouselController,
                          autoPlay: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProductInfo(product: product),
                        const Divider(
                          height: 40,
                          thickness: 10,
                        ),
                        product['descriptionImage'] != null
                            ? GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.fullScreenImage,
                                      arguments: {
                                        'url': product['descriptionImage']
                                      });
                                },
                                child:
                                    Image.network(product['descriptionImage']))
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
