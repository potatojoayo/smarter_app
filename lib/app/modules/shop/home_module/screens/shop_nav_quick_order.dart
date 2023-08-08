import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/shop/home_module/controllers/shop_nav_quick_order_controller.dart';
import 'package:smarter/app/routes/routes.dart';

class ShopNavQuickOrder extends StatefulWidget {
  const ShopNavQuickOrder({Key? key}) : super(key: key);

  @override
  State<ShopNavQuickOrder> createState() => _ShopNavQuickOrderState();
}

class _ShopNavQuickOrderState extends State<ShopNavQuickOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            TextField(
              style: const TextStyle(fontSize: 17),
              controller: ShopNavQuickOrderController.to.contentsController,
              autofocus: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                hintText: '주문하실 내용을 자유롭게 적어주세요.',
                hintStyle: const TextStyle(
                  fontSize: 17,
                ),
                contentPadding: const EdgeInsets.all(20),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 5,
            ),
            const Divider(
              height: 0,
              thickness: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                              activeColor: Get.theme.primaryColorDark,
                              side: BorderSide(
                                width: 1,
                                color: Colors.grey[600]!,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              value:
                                  ShopNavQuickOrderController.to.isVisit.value,
                              onChanged: (value) => ShopNavQuickOrderController
                                  .to.isVisit.value = value!),
                        )),
                    GestureDetector(
                        onTap: () {
                          ShopNavQuickOrderController.to.isVisit.value =
                              !ShopNavQuickOrderController.to.isVisit.value;
                        },
                        child: const DefaultText('방문')),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                            activeColor: Get.theme.primaryColorDark,
                            side: BorderSide(
                              width: 1,
                              color: Colors.grey[600]!,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            value: ShopNavQuickOrderController
                                .to.additionalOrder.value,
                            onChanged: (value) => ShopNavQuickOrderController
                                .to.additionalOrder.value = value!),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          ShopNavQuickOrderController.to.additionalOrder.value =
                              !ShopNavQuickOrderController
                                  .to.additionalOrder.value;
                        },
                        child: const DefaultText('추가주문')),
                  ],
                ),
              ],
            ),
            const Divider(
              height: 4,
              thickness: 5,
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(
              () => ShopNavQuickOrderController.to.files.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: SizedBox(
                        height: 50,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 5,
                          ),
                          itemCount:
                              ShopNavQuickOrderController.to.files.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final file =
                                ShopNavQuickOrderController.to.files[index];
                            return Chip(
                              deleteIcon: const FaIcon(
                                FontAwesomeIcons.solidX,
                                size: 11,
                                color: Colors.white,
                              ),
                              onDeleted: () {
                                ShopNavQuickOrderController.to
                                    .deleteFile(index);
                              },
                              backgroundColor: Get.theme.primaryColorDark,
                              label: DefaultText(
                                file.path.split('/').last,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Container(),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Get.theme.colorScheme.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Get.theme.primaryColorDark,
                          ),
                        ),
                      ),
                      onPressed: ShopNavQuickOrderController.to.selectFiles,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.folderArrowUp,
                            color: Get.theme.primaryColorDark,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '첨부파일추가',
                            style: TextStyle(
                              fontSize: 15,
                              color: Get.theme.primaryColorDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Get.theme.primaryColorDark,
                      ),
                      onPressed:
                          ShopNavQuickOrderController.to.requestQuickOrder,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.solidCartShoppingFast,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '주문하기',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Get.theme.primaryColorDark,
                ),
                onPressed: () => Get.toNamed(Routes.easyOrders),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.clockRotateLeft,
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '간편주문 내역',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
