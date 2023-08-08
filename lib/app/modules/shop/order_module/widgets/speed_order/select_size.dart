import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_controller.dart';

class SelectSize extends StatefulWidget {
  const SelectSize({Key? key, required this.controller}) : super(key: key);

  final SpeedOrderItemController controller;

  @override
  State<SelectSize> createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectSize> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => !widget.controller.useName
        ? ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.controller.productListOfSelectedColor.keys.length,
            itemBuilder: (BuildContext context, int index) {
              final productList = widget
                  .controller.productListOfSelectedColor.values
                  .elementAt(index);
              final color = widget.controller.productListOfSelectedColor.keys
                  .elementAt(index);
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4)),
                child: Column(
                  children: [
                    DefaultText(color),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 64,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: productList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              children: [
                                Container(
                                    width: 120,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(width: 1))),
                                    child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: DefaultText(
                                            "${productList[index]['size']} ${productList[index]['priceAdditional'] > 0 ? '(+ ${formatMoney(productList[index]['priceAdditional'])})' : ''}",
                                            style: TextStyle(
                                                fontSize: productList[index]
                                                            ['priceAdditional'] >
                                                        0
                                                    ? 14
                                                    : 20),
                                          ),
                                      ),
                                    )),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (productList[index]
                                                  .containsKey('quantity') &&
                                              productList[index]['quantity'] >
                                                  0) {
                                            productList[index]['quantity'] -= 1;
                                            if (productList[index]['quantity'] >
                                                0) {
                                              widget.controller
                                                  .changeOrderingProductQuantity(
                                                      productList[index]);
                                            } else {
                                              widget.controller
                                                  .removeOrderingProduct(
                                                      productList[index]);
                                            }
                                            setState(() {});
                                          }
                                        },
                                        child: const SizedBox(
                                          width: 40,
                                          height: 64,
                                          child: Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.minus,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          width: 40,
                                          height: 64,
                                          decoration: const BoxDecoration(
                                              border: Border.symmetric(
                                                  vertical:
                                                      BorderSide(width: 1))),
                                          child: Center(
                                            child: DefaultText(
                                                productList[index]
                                                        .containsKey('quantity')
                                                    ? productList[index]
                                                            ['quantity']
                                                        .toString()
                                                    : '0'),
                                          )),
                                      InkWell(
                                        onTap: () {
                                          if (productList[index]
                                              .containsKey('quantity')) {
                                            productList[index]['quantity'] += 1;
                                            widget.controller
                                                .changeOrderingProductQuantity(
                                                    productList[index]);
                                          } else {
                                            productList[index]['quantity'] = 1;
                                            widget.controller
                                                .addProduct(productList[index]);
                                          }
                                          setState(() {});
                                        },
                                        child: const SizedBox(
                                          width: 40,
                                          height: 64,
                                          child: Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.plus,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 16,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 8,
              );
            },
          )
        : Container());
  }
}
