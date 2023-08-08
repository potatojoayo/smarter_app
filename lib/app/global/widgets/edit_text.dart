import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smarter/app/global/widgets/text.dart';

class EditText extends StatelessWidget {
  const EditText({
    super.key,
    required this.title,
    required this.controller,
    this.inputFormatters = const [],
    this.textInputType,
  });

  final String title;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey[500]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: 80,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Colors.grey[500]!,
                ),
              ),
            ),
            child: Center(
              child: DefaultText(
                title,
                style: Get.textTheme.labelLarge,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              inputFormatters: inputFormatters,
              style: const TextStyle(fontSize: 16),
              keyboardType: textInputType,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
