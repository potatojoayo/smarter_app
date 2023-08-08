import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/utils/format_phone.dart';
import 'package:smarter/app/global/widgets/text.dart';

class DeliveryAddressItem extends StatelessWidget {
  const DeliveryAddressItem(
      {super.key,
      required this.address,
      this.editable = false,
      this.onSelect,
      this.selectable = false,
      this.onEdit});

  final Map<String, dynamic> address;
  final bool editable;
  final bool selectable;
  final void Function(Map<String, dynamic> address)? onSelect;
  final void Function(Map<String, dynamic> address)? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.grey[500]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              '배송지 | ${address['name']}',
              style: Get.textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            address['default']
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.grey[600]!),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DefaultText(
                        '기본배송지',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 8,
            ),
            DefaultText(
              '${address['address']} ${address['detailAddress']}',
              style: TextStyle(color: Colors.grey[600], fontSize: 20),
              overflow: TextOverflow.visible,
            ),
            DefaultText(
              '수취인: ${address['receiver']}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 20,
              ),
            ),
            DefaultText(
              '휴대폰: ${formatPhone(address['phone'])}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                editable
                    ? GestureDetector(
                        onTap: () {
                          if (onEdit != null) {
                            onEdit!(address);
                          }
                        },
                        child: Container(
                          width: 80,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Get.theme.primaryColorDark),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: DefaultText(
                              '수정',
                              style:
                                  TextStyle(color: Get.theme.primaryColorDark),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                selectable
                    ? GestureDetector(
                        onTap: () {
                          if (onSelect != null) {
                            onSelect!(address);
                          }
                        },
                        child: Container(
                          width: 80,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Get.theme.primaryColorDark,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: DefaultText(
                              '선택',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}
