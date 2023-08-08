import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';

class SelectQuantity extends StatelessWidget {
  const SelectQuantity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DefaultText(
              '수량',
              style: Get.textTheme.labelLarge,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  child: Obx(
                    () => Visibility(
                      visible: ProductController.to.quantity > 0,
                      child: IconButton(
                        onPressed: () {
                          ProductController.to.quantity -= 1;
                          ProductController.to.quantityController.text =
                              (int.parse(ProductController
                                          .to.quantityController.text) -
                                      1)
                                  .toString();
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.circleMinus,
                          size: 20,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 48,
                  child: Center(
                    child: TextFormField(
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: const TextStyle(fontSize: 20),
                      controller: ProductController.to.quantityController,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          ProductController.to.quantityController.text = '0';
                          ProductController.to.quantityController.selection =
                              TextSelection.fromPosition(
                                  const TextPosition(offset: 1));
                          ProductController.to.quantity = 0;
                        } else {
                          ProductController.to.quantity = int.parse(
                              ProductController.to.quantityController.text);
                          ProductController.to.quantityController.text =
                              ProductController.to.quantity.toString();
                          ProductController.to.quantityController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: ProductController
                                      .to.quantityController.text.length));
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: IconButton(
                    onPressed: () {
                      ProductController.to.quantity += 1;
                      ProductController.to.quantityController.text = (int.parse(
                                  ProductController
                                      .to.quantityController.text) +
                              1)
                          .toString();
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.circlePlus,
                      size: 20,
                      color: Colors.grey[800],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
