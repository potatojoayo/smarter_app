import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_nav_student_controller.dart';

class ClassDropdownButton extends StatelessWidget {
  const ClassDropdownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GymNavStudentController.to.classes.isNotEmpty
        ? DropdownButton2<String>(
            hint: const DefaultText(
              '클래스',
              style: TextStyle(
                  color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            value: GymNavStudentController.to.selectedClass.value,
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
            items: GymNavStudentController.to.classes
                .map((cls) => DropdownMenuItem<String>(
                      value: cls,
                      child: DefaultText(
                        cls,
                        style: Get.textTheme.labelLarge,
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              GymNavStudentController.to.selectedClass.value = value!;
              GymNavStudentController.to.refetch();
            },
          )
        : Container());
  }
}
