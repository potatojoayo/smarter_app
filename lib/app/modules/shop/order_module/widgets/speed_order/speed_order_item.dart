import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_controller.dart';
import 'package:smarter/app/modules/shop/order_module/controllers/speed_order_item_controller.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/logo_and_name.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/speed_order/select_brand.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/speed_order/select_category.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/speed_order/select_color.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/speed_order/select_draft.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/speed_order/select_product_master.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/speed_order/select_size.dart';
import 'package:smarter/app/modules/shop/order_module/widgets/speed_order/select_sub_category.dart';

class SpeedOrderItem extends StatelessWidget {
  const SpeedOrderItem(
      {Key? key, required this.controller, required this.parentController})
      : super(key: key);

  final SpeedOrderItemController controller;
  final SpeedOrderController parentController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Column(
            children: [
              LogoAndName(controller: controller),
              const SizedBox(
                height: 8,
              ),
              SelectCategory(controller: controller),
              const SizedBox(
                height: 8,
              ),
              SelectSubCategory(controller: controller),
              const SizedBox(
                height: 8,
              ),
              SelectBrand(controller: controller),
              const SizedBox(
                height: 8,
              ),
              SelectProductMaster(controller: controller),
              const SizedBox(
                height: 8,
              ),
              Obx(() =>
              controller.useDraft &&
                  controller.selectedProductMasterName != null
                  ? Column(
                children: [
                  SelectDraft(controller: controller),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              )
                  : Container()),
              Obx(() =>
              !controller.useName &&
                  controller.selectedProductMasterName != null
                  ? controller.useDraft && controller.draftList.isEmpty
                  ? Container()
                  : Column(
                children: [
                  if (controller
                      .selectedProductMaster['colors'].length >
                      1)
                    Column(
                      children: [
                        SelectColor(controller: controller),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  SelectSize(controller: controller),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              )
                  : Container()),
              Obx(() =>
              controller.useName &&
                  controller.selectedProductMasterName != null
                  ? controller.useDraft && controller.draftList.isEmpty
                  ? Container()
                  : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.nameOptionList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < controller.nameOptionList.length) {
                    return controller.nameOptionList[index];
                  } else {
                    return GestureDetector(
                      onTap: () {
                        controller.addNameOption();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                        const Center(child: DefaultText('옵션추가')),
                      ),
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
              )
                  : Container()),
              const SizedBox(
                height: 8,
              ),
              Obx(() =>
              !controller.useName ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DefaultText(
                    '요청사항',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: controller.userRequest,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintStyle: Get.textTheme.labelMedium,
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10),
                        hintText: "요청사항"),
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ) : Container(),
              )
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                parentController.removeSpeedOrderItemWidget(controller);
              },
              child: const FaIcon(
                FontAwesomeIcons.solidCircleX,
                size: 24,
              ),
            ),
          )
        ],
      ),
    );
  }
}
