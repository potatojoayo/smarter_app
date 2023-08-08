import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_controller.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_option_controller.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/students_name_input.dart';

class SpeedOrderOptionItem extends StatelessWidget {
  const SpeedOrderOptionItem({
    super.key,
    required this.controller,
    required this.product,
    required this.draft,
  });

  final SpeedOrderOptionController controller;
  final Map<String, dynamic>? product;
  final Map<String, dynamic>? draft;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonHideUnderline(
                  child: Obx(
                    () => DropdownButton2(
                      hint: const Text(
                        '색상',
                        style: TextStyle(fontSize: 14),
                      ),
                      isExpanded: true,
                      value: controller.selectedColor,
                      items: product?['colors']
                          .map<DropdownMenuItem<String>>(
                            (product) => DropdownMenuItem<String>(
                              value: product,
                              child: DefaultText(product,
                                  maxLines: 3,
                                  style: const TextStyle(fontSize: 16)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        controller.selectedColor = value;
                        // controller.colorRefresh();
                        // ProductController.to.selectedProductDetail = null;
                        controller.productDetailsOfSelectedColor.assignAll(
                          List<Map<String, dynamic>>.from(
                            product?['products']
                                .where((p) => p['color'] == value),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              isExpanded: true,
                              disabledHint: const DefaultText(
                                '색상을 먼저 지정해주세요',
                                style: TextStyle(fontSize: 14),
                              ),
                              hint: DefaultText(
                                '사이즈를 선택하세요',
                                style: Get.textTheme.labelMedium,
                              ),
                              value: controller.productDetailsOfSelectedColor
                                      .contains(
                                          controller.selectedProductDetail)
                                  ? controller.selectedProductDetail
                                  : null,
                              items: controller.productDetailsOfSelectedColor
                                  .map(
                                    (option) =>
                                        DropdownMenuItem<Map<String, dynamic>>(
                                      value: option,
                                      child: Text(
                                        option['size'],
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: controller.selectedColor != null
                                  ? (value) {
                                      controller.selectedProductDetail = value;
                                    }
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all()),
                        child: Obx(
                          () => Text(
                            '수량: ${controller.studentNames.length} 명',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StudentNameInput(controller: controller),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '추가요청사항',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: controller.userRequestController,
                        autofocus: false,
                        decoration: const InputDecoration(
                            // border: OutlineInputBorder(),
                            border: InputBorder.none,
                            hintText: '요청사항을 입력해주세요.'),
                        style: Get.textTheme.labelMedium,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: 10,
          child: GestureDetector(
            onTap: () {
              for (var widgetList
                  in SpeedOrderController.to.speedOrderItemWidgetList) {
                widgetList.controller.orderOptionWidgetList
                    .removeWhere((element) => element.key == key);
              }
            },
            child: FaIcon(
              FontAwesomeIcons.xmark,
              color: Colors.red.shade500,
              size: 20,
            ),
          ),
        ),
      ],
    );
    // : Container(
    //     // width: 100,
    //     // height: 500,
    //     child: Column(
    //       children: [
    //         GestureDetector(
    //             onTap: () {
    //               controller.selectedColorCheckList.value =
    //                   List<bool>.generate(
    //                       (product?['colors'] as List).length,
    //                       (index) => false);
    //               Get.dialog(
    //                 AlertDialog(
    //                   content: SizedBox(
    //                     height: 300,
    //                     width: 200,
    //                     child: SingleChildScrollView(
    //                       child: Column(
    //                         children: [
    //                           GestureDetector(
    //                               onTap: () {
    //                                 controller.selectedColorList.clear();
    //                                 controller.productDetailsOfSelectedColor
    //                                     .clear();
    //                                 for (int i = 0;
    //                                     i <
    //                                         controller
    //                                             .selectedColorCheckList
    //                                             .length;
    //                                     i++) {
    //                                   if (controller
    //                                       .selectedColorCheckList[i]) {
    //                                     controller.selectedColorList
    //                                         .add(product?['colors'][i]);
    //                                     controller
    //                                         .productDetailsOfSelectedColor
    //                                         .addAll(
    //                                       List<Map<String, dynamic>>.from(
    //                                         product?['products'].where(
    //                                             (p) =>
    //                                                 p['color'] ==
    //                                                 product?['colors'][i]),
    //                                       ),
    //                                       // for(var productDetail in controller.productDetailsOfSelectedColor){
    //
    //                                       // }
    //                                     );
    //                                     controller
    //                                             .productDetailsOfSelectedColor[
    //                                         0]['quantity'] = 0;
    //                                     // for(var productDetails in controller.productDetailsOfSelectedColor){
    //                                     //   productDetails.a
    //                                     // }
    //                                   }
    //                                 }
    //                                 print(controller.selectedColorList);
    //                                 controller.colorRefresh();
    //
    //                                 Get.back();
    //                               },
    //                               child: Text('확인')),
    //                           ListView.builder(
    //                               physics: ScrollPhysics(),
    //                               shrinkWrap: true,
    //                               itemCount:
    //                                   (product?['colors'] as List).length,
    //                               itemBuilder: (context, index) {
    //                                 return Row(
    //                                   children: [
    //                                     Obx(
    //                                       () => Checkbox(
    //                                           value: controller
    //                                                   .selectedColorCheckList[
    //                                               index],
    //                                           onChanged: (value) {
    //                                             controller
    //                                                     .selectedColorCheckList[
    //                                                 index] = value;
    //                                           }),
    //                                     ),
    //                                     Text(product?['colors'][index])
    //                                   ],
    //                                 );
    //                               })
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             },
    //             child: Text('색상')),
    //         Obx(() => ListView.builder(
    //             shrinkWrap: true,
    //             itemCount: controller.selectedColorList.length,
    //             itemBuilder: (context, index) {
    //               print(
    //                   controller.productDetailsOfSelectedColor.toString());
    //               return SizedBox(
    //                 width: double.infinity,
    //                 height: 100,
    //                 child: SingleChildScrollView(
    //                   scrollDirection: Axis.horizontal,
    //                   child: Row(
    //                     children: [
    //                       Text(controller.selectedColorList[index]),
    //                       ListView.builder(
    //                           scrollDirection: Axis.horizontal,
    //                           shrinkWrap: true,
    //                           itemCount: controller
    //                               .productDetailsOfSelectedColor
    //                               .where((product) =>
    //                                   product['color'] ==
    //                                   controller.selectedColorList[index])
    //                               .length,
    //                           itemBuilder: (context, index2) {
    //                             return Obx(() => Column(
    //                                   children: [
    //                                     Text(
    //                                       controller
    //                                           .productDetailsOfSelectedColor
    //                                           .value[index]['size'],
    //                                       style: TextStyle(fontSize: 20),
    //                                     ),
    //                                     Row(
    //                                       children: [
    //                                         IconButton(
    //                                           onPressed: () {},
    //                                           icon: const FaIcon(
    //                                             FontAwesomeIcons
    //                                                 .minusCircle,
    //                                             size: 20,
    //                                             color: Colors.grey,
    //                                           ),
    //                                         ),
    //                                         Text(controller.quantity
    //                                             .toString()),
    //                                         IconButton(
    //                                           onPressed: () {
    //                                             controller.quantity += 1;
    //                                             controller
    //                                                 .quantityRefresh();
    //                                             // ProductController.to.quantity += 1;
    //                                             // ProductController.to.quantityController.text = (int.parse(
    //                                             //     ProductController
    //                                             //         .to.quantityController.text) +
    //                                             //     1)
    //                                             //     .toString();
    //                                           },
    //                                           icon: const FaIcon(
    //                                             FontAwesomeIcons.plusCircle,
    //                                             size: 20,
    //                                             color: Colors.grey,
    //                                           ),
    //                                         ),
    //                                       ],
    //                                     )
    //                                   ],
    //                                 ));
    //                           }),
    //                       SizedBox(
    //                         width: 10,
    //                       ),
    //                       // ListView.builder(
    //                       //     scrollDirection: Axis.horizontal,
    //                       //     itemBuilder: (context, index) {
    //                       //       return Column(
    //                       //         children: [
    //                       //           Text('100'),
    //                       //           Row(
    //                       //             children: [Text('-'), Text('1')],
    //                       //           )
    //                       //         ],
    //                       //       );
    //                       //     })
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             }))
    //       ],
    //     ),
    //   );
  }
}
