import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/class_payment_module/controllers/class_payment_controller2.dart';

class RegularFeeSortDropDownButton extends StatelessWidget {
  const RegularFeeSortDropDownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ClassPaymentController2.to.sortType.isNotEmpty
        ? DropdownButton2<String>(
            hint: const DefaultText(
              '정렬순서',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            value: ClassPaymentController2.to.selectedSortType.value,
            dropdownMaxHeight: 200,
            dropdownElevation: 0,
            dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]),
            items: ClassPaymentController2.to.sortType
                .map((sortType) => DropdownMenuItem<String>(
                      value: sortType,
                      child: DefaultText(
                        sortType,
                        style: Get.textTheme.labelLarge,
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              ClassPaymentController2.to.selectedSortType.value = value!;
              ClassPaymentController2.to.refetch();
            },
          )
        : Container());
  }
}
