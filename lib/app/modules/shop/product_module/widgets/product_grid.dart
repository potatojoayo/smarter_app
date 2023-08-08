import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/routes/routes.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key, required this.products, required this.title})
      : super(key: key);

  final List products;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != ''
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultText(title, style: Get.textTheme.bodyLarge),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        '${Routes.product}/${product['id']}',
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey[500]!),
                          borderRadius: BorderRadius.circular(8)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            product['thumbnail'] as String,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DefaultText(
                    product['name'] as String,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    overflow: TextOverflow.visible,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  DefaultText(
                    '${product['subCategory']['name']}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  DefaultText(
                    formatMoney(product['category']['name'] == '도복'
                        ? product['priceGym'] + 3000
                        : product['priceGym']),
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                ],
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              childAspectRatio:
                  ((MediaQuery.of(context).size.width - 48) / 2) / 300),
        ),
      ],
    );
  }
}
