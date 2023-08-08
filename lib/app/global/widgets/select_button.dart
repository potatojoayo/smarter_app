import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/controllers/select_button_controller.dart';
import 'package:smarter/app/global/theme/theme.dart';

class SelectButton extends StatelessWidget {
  const SelectButton({
    Key? key,
    required this.controller,
    this.spaceBetween = 10,
    this.borderColor = textColor,
    this.fontSize = 15,
    required this.onSelect,
  }) : super(key: key);

  final SelectButtonController controller;
  final double spaceBetween;
  final Color borderColor;
  final double fontSize;
  final bool Function() onSelect;

  @override
  Widget build(BuildContext context) {
    final items = RxList<Widget>.from(
      controller.items.asMap().entries.map(
        (entry) {
          final index = entry.key;
          final item = entry.value;
          return InkWell(
            onTap: () {
              for (int i = 0; i < controller.items.length; i++) {
                controller.selected[i] = i == index;
              }
              final temp = controller.selectedValue;
              controller.selectedValue = controller.values[index];
              if (!onSelect()) {
                controller.selectedValue = temp;
              }
            },
            child: Obx(
              () => FittedBox(
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: controller.selected[index] ? textColor : null,
                    border: Border.all(
                      color: borderColor,
                    ),
                  ),
                  child: Center(
                    child: DefaultTextStyle(
                        style: TextStyle(
                          color: controller.selected[index]
                              ? backgroundColor
                              : textColor,
                          fontSize: fontSize,
                        ),
                        child: item),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spaceBetween),
      child: Wrap(
        runSpacing: spaceBetween,
        spacing: spaceBetween,
        children: items,
      ),
    );
  }
}
