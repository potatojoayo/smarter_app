import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';

class DeliveryInfoButton extends StatelessWidget {
  const DeliveryInfoButton({super.key, required this.orderDetail});

  final Map<String, dynamic> orderDetail;

  @override
  Widget build(BuildContext context) {
    return

      InkWell(
        onTap: () {
          final delivery = orderDetail['delivery'];
          Get.bottomSheet(
            Container(
              color: Get.theme.colorScheme.background,
              child: Padding(
                padding: MediaQuery
                    .of(context)
                    .viewInsets,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                    top: 30,
                    bottom: 30,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      delivery['photo'] != null
                          ? SizedBox(
                          width:
                          Get.mediaQuery.size.width * 0.5,
                          child:
                          Image.network(delivery['photo']))
                          : Container(
                        height: 100,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            '배송사',
                            style: Get.textTheme.labelSmall,
                          ),
                          DefaultText(
                            delivery['deliveryAgency']['name'],
                            style: Get.textTheme.labelLarge,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DefaultText(
                            '송장번호',
                            style: Get.textTheme.labelSmall,
                          ),
                          DefaultText(
                            delivery['trackingNumber'],
                            style: Get.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          child: DefaultText(
            '배송정보',
            style: TextStyle(
                fontSize: 15, color: Get.theme.primaryColorDark),
          ),
        ),
      );
  }
}
