import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/theme/theme.dart';
import 'package:smarter/app/global/widgets/text.dart';
import 'package:smarter/app/modules/gym/home_module/controllers/gym_nav_student_controller.dart';

class LevelDropdownButton extends StatelessWidget {
  const LevelDropdownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GymNavStudentController.to.levels.isNotEmpty
        ? DropdownButton2<String>(
            hint: const DefaultText(
              '급수',
              style: TextStyle(
                  color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            value: GymNavStudentController.to.selectedLevel.value,
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
            items: GymNavStudentController.to.levels
                .map((cls) => DropdownMenuItem<String>(
                      value: cls,
                      child: DefaultText(
                        cls,
                        style: Get.textTheme.labelLarge,
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              GymNavStudentController.to.selectedLevel.value = value!;
              GymNavStudentController.to.refetch();
            },
          )
        : Container());
  }
}
