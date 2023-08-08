import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/modules/my_page_module/widgets/delivery_address_item.dart';
import 'package:smarter/app/routes/routes.dart';

class DeliveryAddressInfo extends StatelessWidget {
  const DeliveryAddressInfo(
      {Key? key,
      required this.addresses,
      this.onSelect,
      required this.address,
      required this.type,
      this.refetch,
      required this.selectable})
      : super(key: key);

  final List<Map<String, dynamic>> addresses;
  final Rx<Map<String, dynamic>?> address;
  final void Function(Map<String, dynamic> address)? onSelect;
  final String type;
  final Function? refetch;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Get.toNamed(
          Routes.changeDeliveryAddress,
          arguments: {'selectable': selectable, 'type': type},
        );
        if (refetch != null) {
          refetch!();
        }
      },
      child: Obx(
        () => DeliveryAddressItem(
          address: address.value!,
          onSelect: onSelect,
        ),
      ),
    );
  }
}
