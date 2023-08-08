import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/image_carousel.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_controller.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';
import 'package:smarter/graphql_api.dart';

class SelectDraft extends StatelessWidget {
  const SelectDraft({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SpeedOrderItemController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.draftList.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ImageCarousel(
                    enableInfiniteScroll: false,
                    onPageChanged: (index) {
                      controller.selectDraft(index);
                    },
                    images: [
                      for (MyDrafts$Query$NewDraftType draft
                          in controller.draftList)
                        Image.network(draft.image!)
                    ],
                    controller:
                        ProductController.to.logoImageCarouselController,
                    autoPlay: false,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          '작업비',
                          style: Get.textTheme.labelMedium,
                        ),
                        Obx(
                          () => DefaultText(
                            formatMoney(controller.selectedDraft!.priceWork!),
                            style: Get.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Obx(() => controller.selectedDraft!.font != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                '폰트',
                                style: Get.textTheme.labelMedium,
                              ),
                              Obx(
                                () => DefaultText(
                                  controller.selectedDraft!.font!,
                                  style: Get.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          )
                        : Container()),
                    const SizedBox(
                      width: 30,
                    ),
                    Obx(() => controller.selectedDraft!.threadColor != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                '실색상',
                                style: Get.textTheme.labelMedium,
                              ),
                              Obx(
                                () => DefaultText(
                                  controller.selectedDraft!.threadColor!,
                                  style: Get.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          )
                        : Container()),
                  ],
                ),
              ],
            )
          : ElevatedButton(
              onPressed: () async {
                await controller.requestDraft();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.primaryColorDark),
              child: const DefaultText(
                '로고 시안 등록 요청',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
    );
  }
}
