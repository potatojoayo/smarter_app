import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_money.dart';
import 'package:smarter/app/global/widgets/image_carousel.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/product_module/controllers/product_controller.dart';

class LogoSetting extends StatelessWidget {
  const LogoSetting({
    Key? key,
    required this.drafts,
  }) : super(key: key);

  final List<Map<String, dynamic>> drafts;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ProductController.to.useDraft
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ImageCarousel(
                    enableInfiniteScroll: false,
                    onPageChanged: (index) {
                      ProductController.to.selectedDraft = drafts[index];
                    },
                    images: [
                      for (var draft in drafts) Image.network(draft['image'])
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
                            formatMoney(drafts[ProductController.to.draftIndex]
                                ['priceWork']),
                            style: Get.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Obx(() =>
                        drafts[ProductController.to.draftIndex]['font'] != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultText(
                                    '폰트',
                                    style: Get.textTheme.labelMedium,
                                  ),
                                  Obx(
                                    () => DefaultText(
                                      drafts[ProductController.to.draftIndex]
                                          ['font'],
                                      style: Get.textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              )
                            : Container()),
                    const SizedBox(
                      width: 30,
                    ),
                    Obx(() => drafts[ProductController.to.draftIndex]
                                ['threadColor'] !=
                            null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                '실색상',
                                style: Get.textTheme.labelMedium,
                              ),
                              Obx(
                                () => DefaultText(
                                  drafts[ProductController.to.draftIndex]
                                      ['threadColor'],
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
          : const SizedBox.shrink(),
    );
  }
}
