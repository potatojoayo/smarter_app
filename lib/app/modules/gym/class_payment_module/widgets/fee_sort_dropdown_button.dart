import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/class_payment_module/controllers/class_payment_controller.dart';

class FeeSortDropDownButton extends StatelessWidget {
  const FeeSortDropDownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ClassPaymentController.to.sortType.isNotEmpty
        ? DropdownButton2<String>(
            hint: const DefaultText(
              '정렬순서',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            value: ClassPaymentController.to.selectedSortType.value,
            dropdownMaxHeight: 200,
            dropdownElevation: 0,
            dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(1, 1),
                      spreadRadius: 1)
                ]),
            items: ClassPaymentController.to.sortType
                .map((sortType) => DropdownMenuItem<String>(
                      value: sortType,
                      child: DefaultText(
                        sortType,
                        style: Get.textTheme.labelLarge,
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              ClassPaymentController.to.selectedSortType.value = value!;
              ClassPaymentController.to.refetch();
            },
          )
        : Container());
  }
}
